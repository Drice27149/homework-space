#import "Record.h"

@implementation Record 

-(id) init{
    Images = [[NSMutableArray alloc] init];
    return self;
}

-(NSString*) CutString:(NSString*)s{
    NSString* result = [[NSString alloc]init];
    int DisplayMax = 20;
    int MaxLen = s.length>DisplayMax?DisplayMax:(int)s.length;
    for(int i = 0; i < MaxLen; i++){
        char Current = [s characterAtIndex:i];
        if(Current=='\n'){
            break;
        }
        else{
            result = [NSString stringWithFormat:@"%@%c",result,Current];
        }
    }
    if(s.length>DisplayMax){
        result = [NSString stringWithFormat:@"%@ ......",result];
    }
    return result;
}

-(NSString*) GetCellText{
    NSString* text = [[NSString alloc] initWithFormat:@"时间: %@\n地点: %@\n心得: %@",[self CutString:self.Date],[self CutString:self.Location],[self CutString:self.Note]];
    return text;
}

-(NSString*) GetDetailText{
    NSString* text = [[NSString alloc] initWithFormat:@"%@\n\n%@\n\n%@\n\n%@\n",self.Date,self.Location,self.Name,self.Note];
    return text;
}

@end
