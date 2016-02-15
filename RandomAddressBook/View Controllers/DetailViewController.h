#import <UIKit/UIKit.h>
#import "NetworkRequests.h"


@interface DetailViewController : UIViewController <NSURLSessionDataDelegate>

@property (strong, nonatomic) NSDictionary *selectedContact;
@property (weak, nonatomic) IBOutlet UIImageView *contactPortraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactPhoneLabel;
@property (weak, nonatomic) IBOutlet UITextView *contactAddressTextView;


@end