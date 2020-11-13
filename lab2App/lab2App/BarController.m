#import "BarController.h"
#import "DiscoverVC.h"
#import "CreateVC.h"
#import "NavigationController.h"
#import "SettingVC.h"

@implementation BarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DiscoverVC* discoverVC = [[DiscoverVC alloc] init];
    discoverVC.TabBarVC = self;
    NavigationController* DiscoverTab = [[NavigationController alloc] initWithRootViewController: discoverVC];
    DiscoverTab.tabBarItem.image = [[UIImage imageNamed:@"pic/discover0.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    DiscoverTab.tabBarItem.selectedImage = [[UIImage imageNamed:@"pic/discover1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    DiscoverTab.tabBarItem.title = @"发现";
   
    CreateVC* createVC =[[CreateVC alloc]init];
    createVC.MyDsicover = discoverVC;
    createVC.TabBarVC = self;
    NavigationController* CreateTab = [[NavigationController alloc] initWithRootViewController: createVC];
    CreateTab.tabBarItem.image = [[UIImage imageNamed:@"pic/create0.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CreateTab.tabBarItem.selectedImage = [[UIImage imageNamed:@"pic/create1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CreateTab.tabBarItem.title = @"打卡";
    CreateTab.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    
    SettingVC* settingVC =[[SettingVC alloc]init];
    NavigationController* SettingTab = [[NavigationController alloc] initWithRootViewController: settingVC];
    SettingTab.tabBarItem.image = [[UIImage imageNamed:@"pic/home0.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SettingTab.tabBarItem.selectedImage = [[UIImage imageNamed:@"pic/home1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SettingTab.tabBarItem.title = @"我的";
    
    self.viewControllers = @[DiscoverTab,CreateTab,SettingTab];
}

@end
