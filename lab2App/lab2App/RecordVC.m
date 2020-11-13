#import "RecordVC.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define FONT_SIZE 20

@implementation RecordVC{
    Record* record;
    float imageSize;
}

-(id) initWithRecord:(Record*)MyRecord{
    record = MyRecord;
    return self;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    float ItemWidth = SCREEN_WIDTH*0.28;
    float ItemSpace = SCREEN_WIDTH*0.04;
    float HeadBlank = SCREEN_HEIGHT*0.04;
    float LabelWidth = SCREEN_WIDTH*0.92;
    imageSize = ItemWidth;
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSString* text = [record GetDetailText];
    UILabel* label = [self GetLabel:text Width:LabelWidth beginX:ItemSpace beginY:HeadBlank];
    label.layer.borderWidth = 0;
    [self.view addSubview:label];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = ItemSpace;
    flowLayout.minimumInteritemSpacing = ItemSpace;
    flowLayout.itemSize = CGSizeMake(ItemWidth,ItemWidth);
    flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);

    UICollectionView* imageView = [[UICollectionView alloc]
                                   initWithFrame: CGRectMake(ItemSpace,HeadBlank+label.frame.size.height,SCREEN_WIDTH-ItemSpace*2,self.view.frame.size.height)
                 collectionViewLayout:flowLayout];
    imageView.dataSource = self;
    imageView.backgroundColor = [UIColor whiteColor];
    [imageView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"qiaonima"];
    [self.view addSubview:imageView];
    self.navigationItem.title = @"查看打卡";
}

-(float) CalTextHeight: (NSString*)text Width:(float) width{
    UILabel* label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = text;
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:label.font forKey:NSFontAttributeName] context:nil].size;
    return size.height;
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

#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [record->Images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"qiaonima" forIndexPath:indexPath];
    //loadImage
    UIImageView* imageView = [[UIImageView alloc] initWithImage:record->Images[indexPath.row]];
    imageView.frame = CGRectMake(0,0,imageSize,imageSize);
    [cell addSubview:imageView];
    return cell;
}

@end
