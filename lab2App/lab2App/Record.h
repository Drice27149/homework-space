#import <UIKit/UIKit.h>

@interface Record: NSObject{
    @public NSMutableArray* Images; 
}

@property NSString* Date;
@property NSString* Location;
@property NSString* Name;
@property NSString* Note;

-(NSString*) GetCellText;

-(NSString*) GetDetailText;

@end
