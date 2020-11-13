#import <UIKit/UIKit.h>
#import "Record.h"

@interface RecordVC: UIViewController <UICollectionViewDataSource>

-(id) initWithRecord:(Record*)MyRecord;

@end
