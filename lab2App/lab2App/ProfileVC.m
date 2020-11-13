#import "ProfileVC.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define FONT_SIZE 18

@implementation ProfileVC

-(void) viewDidLoad{
    [super viewDidLoad];
    float circleSize = SCREEN_WIDTH*0.5;
    float bigSize = SCREEN_WIDTH*0.6;
    float blankSpace = SCREEN_HEIGHT*0.05;
    
    UILabel* circleLabel = [[UILabel alloc] init];
    circleLabel.frame = CGRectMake((SCREEN_WIDTH-circleSize)*0.5, circleSize*0.8, circleSize, circleSize);
    circleLabel.layer.cornerRadius = circleSize*0.5;
    circleLabel.layer.borderColor = [UIColor blackColor].CGColor;
    circleLabel.layer.borderWidth = 1.0;
    [self.view addSubview:circleLabel];
    
    UILabel* rectLabel = [self GetLabel:@"  用户名\n  邮箱\n  电话" Width:circleSize beginX:(SCREEN_WIDTH-circleSize)*0.5 beginY:circleSize*1.8+blankSpace];
    [self.view addSubview:rectLabel];
    
    UILabel* aboutLabel = [self GetLabel:@"关于" Width:bigSize beginX:(SCREEN_WIDTH-bigSize)/2 beginY:circleSize*2+rectLabel.frame.size.height+1.5*blankSpace];
    aboutLabel.layer.borderWidth = 0.0;
    [self.view addSubview:aboutLabel];
    
    UILabel* settingLabel = [self GetLabel:@"  版本\n\n  隐私和Cookie\n\n  缓存\n\n  同步" Width: bigSize beginX:(SCREEN_WIDTH-bigSize)/2 beginY:circleSize*2+rectLabel.frame.size.height+2*blankSpace];
    [self.view addSubview:settingLabel];
    self.navigationItem.title = @"我的";
}

-(UILabel*) GetLabel: (NSString*)text Width:(float) width beginX:(float)x beginY:(float)y{
    UILabel* label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:FONT_SIZE];
    label.text = text;
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:label.font forKey:NSFontAttributeName] context:nil].size;
    label.frame = CGRectMake(x, y, width, size.height);
    label.layer.borderColor = [UIColor blackColor].CGColor;
    label.layer.borderWidth = 1.0;
    return label;
}

@end
