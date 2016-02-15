#import <Foundation/Foundation.h>
#import "NetworkRequests.h"


@interface NetworkRequests : NSObject

+ (void)fetchRandomContactAsynchronouslyFromStringURL:(NSString *)address withCompletionBlock:(void (^)(NSData *returnedData, NSURLResponse *response, NSError *error))completionBlock;

+ (void)fetchImageViewAsynchronouslyFromStringURL:(NSString *)strImageURL withCompletionBlock:(void(^)(NSURL *location, NSURLResponse *response, NSError *error))completionBlock;

@end
