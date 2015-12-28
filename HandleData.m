//
//  HandleData.m


#import "HandleData.h"

@implementation HandleData
+ (void)handleDataWithString:(NSString *)string block:(void (^)(id responseObject))block placeBlock:(void (^)(id placeResponseObject))placeBlock
{
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:string]];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%lu.txt", docPath, (unsigned long)[string hash]];
    id placeResponseObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (placeResponseObject != nil) {
        placeBlock(placeResponseObject);
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:string parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (responseObject != nil) {
            BOOL result = [NSKeyedArchiver archiveRootObject:responseObject toFile:path];
            NSLog(@"是否缓存成功: %d",result);
            block(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        id responseObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (responseObject != nil) {
            block(responseObject);
        }
    }];
}

@end
