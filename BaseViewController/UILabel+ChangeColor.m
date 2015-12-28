//
//  UILabel+ChangeColor.m


#import "UILabel+ChangeColor.h"

@implementation UILabel (ChangeColor)
- (void)sendColor
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"] == 5) {
        self.textColor = [UIColor colorWithRed:255/255.0 green:106/255.0 blue:106/255.0 alpha:1.0];
    }
    else if ([[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"] == 4){
        self.textColor = [UIColor cyanColor];
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"] == 0  ){
        self.textColor = [UIColor blackColor];
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"isWhite"] == 6 )
    {
        self.textColor = [UIColor blackColor];
        
    }
    else{
        self.textColor = [UIColor lightTextColor];
    }
}
@end
