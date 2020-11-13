#import <UIKit/UIKit.h>
#import "Record.h"
#import "DiscoverVC.h"
#import "BarController.h"

@interface CreateVC : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

//set from outside
@property DiscoverVC* MyDsicover;

@property BarController* TabBarVC;

-(id) init;

@end
