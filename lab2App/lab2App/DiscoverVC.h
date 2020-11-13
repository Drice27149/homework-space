#import <UIKit/UIKit.h>
#import "Record.h"
#import "BarController.h"

@interface DiscoverVC: UIViewController <UICollectionViewDelegate,UICollectionViewDataSource, UISearchBarDelegate>

@property NSMutableArray* records;

@property UICollectionView* displayTable;

@property BarController* TabBarVC;

-(void) addRecord: (Record*) record;

-(void) deleteAnimation:(CAReplicatorLayer*) CurrentLayer;

@end
