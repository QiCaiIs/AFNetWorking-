//
//  BaseViewController.h


#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
@interface BaseViewController : UIViewController
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIButton *but;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) NSMutableDictionary *dic;
- (void)sendColor;
- (void)changeModel;
@end
