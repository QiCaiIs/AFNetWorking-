//
//  BaseViewController.m


#import "BaseViewController.h"
#import "HandleData.h"
#import "UILabel+ChangeColor.h"
#import "PrefixHeader.pch"
@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.alpha = 1;
    [self sendColor];
    for (UITableView *tabel in self.view.subviews) {
        if ([tabel isKindOfClass:[UITableView class]]) {
            tabel.backgroundColor = [UIColor clearColor];
            [tabel reloadData];
        }
    }
    [self.but addTarget:self action:@selector(buttAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"简约.png"],@1,[UIImage imageNamed:@"星空.png"],@2,[UIImage imageNamed:@"古风.jpeg"],@3,[UIImage imageNamed:@"卡通.jpeg"],@4, nil];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"centerBut"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"centerBut"];
        self.but = [UIButton buttonWithType:UIButtonTypeSystem];
        self.but.frame = CGRectMake(self.view.bounds.size.width/2-25, -20, 50, 200);
        UIImage *image = [UIImage imageNamed:@"中间的.png"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.but.imageEdgeInsets = UIEdgeInsetsMake( -70, 0, 70, 0);
        [self.but setImage:image forState:UIControlStateNormal];
        [self.tabBarController.tabBar addSubview:self.but];
        self.but.layer.cornerRadius = 25;
        self.but.backgroundColor = [UIColor colorWithRed:255/255.0 green:215/255.0 blue:0/255.0 alpha:0.8];
        [self.but addTarget:self action:@selector(buttAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-150, 50)];
    self.textLabel = [[UILabel alloc] initWithFrame:self.navigationItem.titleView.bounds];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationItem.titleView addSubview:self.textLabel];
    [self sendColor];
    
    self.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:0/255.0 alpha:1.0];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"] == DAYMODEL) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:245/255.0 green:13/255.0 blue:53/255.0 alpha:1];
       
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    }
    else{
        NSNumber *i = [NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"]];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[self.dic objectForKey:i]];
        self.tabBarController.tabBar.barTintColor = [UIColor colorWithPatternImage:[self.dic objectForKey:i]];
    }
    self.navigationController.navigationBar.translucent = NO;
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.hud.labelText = @"努力加载中...";
    
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receivieNotification:) name:@"change model" object:nil ];
    
}
- (void)buttAction:(UIButton *)but
{
    NSLog(@"你好");
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = @"cube";
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
}
- (void)viewDidLayoutSubviews
{
    [self sendColor];
}
- (void)receivieNotification:(NSNotification *)noti
{
    
}
- (void)addMyDic
{
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"image"];
    NSData *data = [NSData dataWithContentsOfFile:fullPath];
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        [self.dic setObject:image forKey:@5];
    }
}
- (void)sendColor
{
    [self addMyDic];
    NSLog(@"send%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"]);
    
    self.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:0/255.0 alpha:1.0];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"] == DAYMODEL) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:245/255.0 green:13/255.0 blue:53/255.0 alpha:1];
        
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    }
    else{
        NSNumber *i = [NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"]];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[self.dic objectForKey:i]];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[self.dic objectForKey:i]];
        self.tabBarController.tabBar.barTintColor = [UIColor colorWithPatternImage:[self.dic objectForKey:i]];
        for (UILabel *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UILabel class]]) {
                subview.textColor = [UIColor whiteColor];
            }
        }
        for (UICollectionView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UICollectionView class]]) {
                subview.backgroundColor = self.view.backgroundColor;
            }
        }
    }
}
- (void)changeModel
{
    [self addMyDic];
    NSInteger isWhite = [[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"];
    NSLog(@"change%ld",(long)isWhite);
    
    self.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:0/255.0 alpha:1.0];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"] == DAYMODEL) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:245/255.0 green:13/255.0 blue:53/255.0 alpha:1];
        
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    }
    else{
        NSNumber *i = [NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"]];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[self.dic objectForKey:i]];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[self.dic objectForKey:i]];
        self.tabBarController.tabBar.barTintColor = [UIColor colorWithPatternImage:[self.dic objectForKey:i]];
        for (UILabel *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UILabel class]]) {
                subview.textColor = [UIColor whiteColor];
            }
        }
        for (UICollectionView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UICollectionView class]]) {
                subview.backgroundColor = self.view.backgroundColor;
            }
        }
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
