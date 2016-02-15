#import "NetworkRequests.h"


@implementation NetworkRequests

+ (void)fetchRandomContactAsynchronouslyFromStringURL:(NSString *)address withCompletionBlock:(void (^)(NSData *returnedData, NSURLResponse *response, NSError *error))completionBlock {
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  [request setURL:[NSURL URLWithString:address]];
  [request setHTTPMethod:@"GET"];
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
  [[session dataTaskWithRequest:request completionHandler:completionBlock] resume];
}

+ (void)fetchImageViewAsynchronouslyFromStringURL:(NSString *)strImageURL withCompletionBlock:(void(^)(NSURL *location, NSURLResponse *response, NSError *error))completionBlock {
  
  NSURLSession *session =
  [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
  
  [[session downloadTaskWithURL:[NSURL URLWithString:strImageURL] completionHandler:completionBlock] resume];
}

@end
