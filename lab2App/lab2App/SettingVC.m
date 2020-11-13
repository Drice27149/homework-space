#import "SettingVC.h"
#import "SubButton.h"
#import "ProfileVC.h"

@implementation SettingVC

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

-(void) viewDidLoad{
    [super viewDidLoad];
    float circleSize = SCREEN_WIDTH*0.55;
    float HeadBlank = (SCREEN_HEIGHT-circleSize)*0.5;
    SubButton* submitButton = [[SubButton alloc]initWithFrame:
                               CGRectMake((SCREEN_WIDTH-circleSize)/2,HeadBlank,circleSize,circleSize)];
    submitButton.owner = self;
    [submitButton setTitle:@"登录" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    submitButton.layer.cornerRadius = circleSize*0.5;
    submitButton.layer.borderColor = [UIColor blackColor].CGColor;
    //submitButton.layer.borderWidth = 1.0;
    submitButton.backgroundColor = UIColor.whiteColor;
    [self.view addSubview: submitButton];
    self.navigationItem.title = @"我的";
    
    CAGradientLayer *colorLayer0 = [CAGradientLayer layer];
    float gap = 0.09;
    colorLayer0.frame    = CGRectMake(0, SCREEN_HEIGHT*gap, SCREEN_WIDTH, SCREEN_HEIGHT*(1.0-gap-gap));
    colorLayer0.colors = @[(__bridge id)[UIColor whiteColor].CGColor,
                          (__bridge id)[UIColor grayColor].CGColor];
    colorLayer0.startPoint = CGPointMake(0.5, 0.5);
    colorLayer0.endPoint  = CGPointMake(1, 1);
    colorLayer0.zPosition = -1.0;
    colorLayer0.type = kCAGradientLayerRadial;
    [self.view.layer addSublayer:colorLayer0];
}

-(void) onButtonClick:(SubButton*) currentButton{
    UIViewController* owner = currentButton.owner;
    //push or present, todo
    [owner.navigationController pushViewController:[[ProfileVC alloc] init] animated:NO];
}

@end
