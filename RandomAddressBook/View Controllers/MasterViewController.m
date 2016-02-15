#import "MasterViewController.h"


static NSString * const kRandomUserURL = @"https://randomuser.me/api/";

@interface MasterViewController ()

@property (nonatomic, strong) NSMutableArray *contacts;

@end


@implementation MasterViewController

#pragma mark - NSObject

- (void)viewDidLoad {
  
  [super viewDidLoad];
  [self configureUI];
  self.contacts = [[NSMutableArray alloc] init];
}

#pragma mark - Configure UI

- (void)configureUI {
  [self configureNavBar];
}

- (void)configureNavBar {
  
  self.navigationItem.title = @"My Contacts";
  
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewContact)];
  self.navigationItem.rightBarButtonItem = addButton;
}

#pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  if ([self.contacts count] != 0) {
    // Clear the message label when contacts have loaded
    self.tableView.backgroundView = nil;
    return 1;
  } else {
    // Display a message when the table is empty
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    messageLabel.text = @"Click on the '+' button in the navigation bar to add a random contact!";
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [messageLabel sizeToFit];
    
    self.tableView.backgroundView = messageLabel;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  }
  return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  if (self.contacts)
    return [self.contacts count];
  else
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  
  if (self.contacts) {
    NSDictionary *myContact = [self.contacts objectAtIndex:indexPath.row];
    NSDictionary *fullName = [myContact objectForKey:@"name"];
    NSString *firstName = [fullName objectForKey:@"first"];
    NSString *lastName = [fullName objectForKey:@"last"];
    NSString *title = [fullName objectForKey:@"title"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@. %@ %@", title, firstName, lastName];
  }
}

#pragma mark - Contacts

- (void)insertNewContact {
  
  [NetworkRequests fetchRandomContactAsynchronouslyFromStringURL:kRandomUserURL withCompletionBlock:^(NSData *returnedData, NSURLResponse *response, NSError *error) {
    
    if (returnedData == nil) {
      NSLog(@"Query failed!");
      return;
    }
    if (error) {
      NSLog(@"Error! Description is %@", error.description);
      return;
    }
    NSError *jsonError = nil;
    id object = [NSJSONSerialization JSONObjectWithData:returnedData
                                                options:0
                                                  error:&jsonError];
    if (jsonError) {
      NSLog(@"JSON was malformed. Error is %@", jsonError.description);
      return;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
      NSDictionary *JSONresponse = object;
      NSArray *randomUserData = [JSONresponse objectForKey:@"results"];
      NSDictionary *newContactData = [randomUserData objectAtIndex:0];
      NSDictionary *newContact = [newContactData objectForKey:@"user"];

      [self.contacts addObject:newContact];
        
      // always update UI on main thread
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
      });
    }
  }];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  if ([[segue identifier] isEqualToString:@"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DetailViewController *myDetailViewController = (DetailViewController *)[segue destinationViewController];
    myDetailViewController.selectedContact = [self.contacts objectAtIndex:indexPath.row];
  }
}

@end
