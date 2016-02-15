#import <XCTest/XCTest.h>
#import "NetworkRequests.h"


@interface NetworkRequestsTests : XCTestCase

@end


@implementation NetworkRequestsTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAsynchronousFetchForJSONFromRandomUserGeneratorAPI {
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"Asychronous request to Random User Generator for JSON object."];
  
  NSString *testURL = @"https://randomuser.me/api/";
  
  [NetworkRequests fetchRandomContactAsynchronouslyFromStringURL:testURL withCompletionBlock:^(NSData *returnedData, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"Error is: %@", error);
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode = [httpResponse statusCode];
      XCTAssertEqual(statusCode, 200);
      [expectation fulfill];
    }
  }];

  [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
    if (error) {
      XCTFail(@"Expectation failed with error: %@", error);
    }
  }];
}

- (void)testAsynchronousFetchForImageFromRandomUserGeneratorAPI {
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"Asychronous request to Random User Generator for UIImage data."];
  
  NSString *testURL = @"https://randomuser.me/api/portraits/men/21.jpg";

  [NetworkRequests fetchImageViewAsynchronouslyFromStringURL:testURL withCompletionBlock:^(NSURL *location, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"Error is: %@", error);
    } else {
      UIImage *downloadedImage = [UIImage imageWithData:
                                  [NSData dataWithContentsOfURL:location]];
      XCTAssert(downloadedImage != nil);
      [expectation fulfill];
    }
  }];
  
  [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
    if (error) {
      XCTFail(@"Expectation failed with error: %@", error);
    }
  }];
}

@end
