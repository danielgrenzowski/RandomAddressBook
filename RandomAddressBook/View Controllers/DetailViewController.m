#import "DetailViewController.h"


@interface DetailViewController ()

@end


@implementation DetailViewController

#pragma mark - NSObject

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configureUI];
}

#pragma mark - Configure UI

- (void)configureUI {
  
  [self configureNavBar];
  
  if (self.selectedContact) {
    [self configureContactPortraitImageView];
    [self configureContactNameLabel];
    [self configureContactEmailLabel];
    [self configureContactPhoneLabel];
    [self configureContactAddressTextView];
  }
}

- (void)configureNavBar {
  
  self.navigationItem.title = @"Contact Info";
}

- (void)configureContactPortraitImageView {
  
  NSString *strImageURL = [[self.selectedContact objectForKey:@"picture"] objectForKey:@"medium"];

  [NetworkRequests fetchImageViewAsynchronouslyFromStringURL:(NSString *)strImageURL withCompletionBlock:^(NSURL *location,
                                 NSURLResponse *response,
                                 NSError *error) {
    UIImage *downloadedImage = [UIImage imageWithData:
    [NSData dataWithContentsOfURL:location]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      self.contactPortraitImageView.image = downloadedImage;
    });
  }];
}

- (void)configureContactNameLabel {
  
  NSDictionary *dictFullName = [self.selectedContact objectForKey:@"name"];
  NSString *firstName = [dictFullName objectForKey:@"first"];
  NSString *lastName = [dictFullName objectForKey:@"last"];
  NSString *title = [dictFullName objectForKey:@"title"];
  NSString *strFullName = [NSString stringWithFormat:@"%@. %@ %@", title, firstName, lastName];
  [self configureLabel:self.contactNameLabel withText:strFullName];
}

- (void)configureContactEmailLabel {
  
  NSString *contactEmail = [self.selectedContact objectForKey:@"email"];
  [self configureLabel:self.contactEmailLabel withText:contactEmail];
}

- (void)configureContactPhoneLabel {
  
  NSString *contactPhone = [self.selectedContact objectForKey:@"phone"];
  [self configureLabel:self.contactPhoneLabel withText:contactPhone];
}

- (void)configureContactAddressTextView {
  
  NSDictionary *dictFullAddress = [self.selectedContact objectForKey:@"location"];
  NSString *street = [dictFullAddress objectForKey:@"street"];
  NSString *city = [dictFullAddress objectForKey:@"city"];
  NSString *state = [dictFullAddress objectForKey:@"state"];
  NSString *zip = [dictFullAddress objectForKey:@"zip"];

  NSString *strFullAddress = [NSString stringWithFormat:@"%@, %@, %@ %@", street, city, state, zip];
  self.contactAddressTextView.text = strFullAddress;
  self.contactAddressTextView.font = [UIFont systemFontOfSize:17];
  self.contactAddressTextView.editable = NO;
  [self.contactAddressTextView setTextContainerInset:UIEdgeInsetsMake(5, -5, 0, 0)];
}

#pragma mark - Helpers

- (void)configureLabel:(UILabel *)myLabel withText:(NSString *)myString {
  
  myLabel.numberOfLines = 0;
  myLabel.text = myString;
}

@end
