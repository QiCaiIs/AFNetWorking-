//
//  HandleData.h


#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface HandleData : NSObject
+ (void)handleDataWithString:(NSString *)string block:(void (^)(id responseObject))block placeBlock:(void (^)(id placeResponseObject))placeBlock;
@end
