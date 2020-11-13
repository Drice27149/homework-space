#import "DiscoverVC.h"
#import "NavigationController.h"
#import "BarController.h"
#import "RecordVC.h"
#import "SubButton.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SAMPLE_STRING (@"Date:\nLocation:\nName:\n")
#define FONT_SIZE 22

@implementation DiscoverVC{
    NSString* searchText;
    NSMutableArray* goodRecords;
    float LastContentOffsetY;
    float eps;
    int queue[2005];
    int head, tail;
}

-(id) init{
    self.records = [[NSMutableArray alloc] init];
    LastContentOffsetY = 0.0;
    eps = 1e-8;
    head = 1000;
    tail = 999;
    return self;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    float ItemWidth = SCREEN_WIDTH*0.9;
    float ItemHeight = [self CalCellHeight]*1.25;
    float ItemSpace = SCREEN_HEIGHT*0.02;
    float CollectionViewHeight = self.view.frame.size.height*0.77;
    
    //todo: search bar border
    UISearchBar* searchBar = [[UISearchBar alloc]init];
    searchBar.frame = CGRectMake(0, 5, SCREEN_WIDTH, ItemSpace*2);
    searchBar.delegate = self;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.searchTextField.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:searchBar];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = ItemSpace;
    flowLayout.minimumInteritemSpacing = ItemSpace;
    flowLayout.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(ItemSpace, ItemSpace, ItemSpace, ItemSpace);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 2*ItemSpace+ItemSpace/10, self.view.frame.size.width, CollectionViewHeight) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = UIColor.clearColor;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"qiaonima"];
    
    self.displayTable = collectionView;
    [self.view addSubview: self.displayTable];
    self.navigationItem.title = @"打卡清单";
    //debug
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.frame    = self.view.frame;
    colorLayer.colors = @[(__bridge id)[UIColor grayColor].CGColor,
                          (__bridge id)[UIColor whiteColor].CGColor];
    colorLayer.startPoint = CGPointMake(0, 0);
    colorLayer.endPoint  = CGPointMake(1.0, 1.0);
    colorLayer.zPosition = -1.0;
    [self.view.layer addSublayer:colorLayer];
    
    float BlankSpace = SCREEN_WIDTH*0.04;
    ItemWidth = SCREEN_WIDTH*0.28;
    float LineHeight = [self CalTextHeight:@" " Width:100];
    float Xposition = BlankSpace*3+ItemWidth*2;
    
    SubButton* submitButton = [[SubButton alloc]initWithFrame:CGRectMake(Xposition, BlankSpace*3+12*LineHeight+BlankSpace*2+BlankSpace+2*ItemWidth+BlankSpace*2, ItemWidth, ItemWidth*0.35)];
    submitButton.owner = self;
    [submitButton setTitle:@"Create" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    submitButton.backgroundColor = UIColor.whiteColor;
    submitButton.layer.borderColor = [UIColor grayColor].CGColor;
    submitButton.layer.borderWidth = 1.0;
    [self.view addSubview: submitButton];
}

-(void) onButtonClick:(SubButton*) currentButton{
    self.TabBarVC.selectedIndex = 1;
}

-(void) addRecord: (Record*) record{
    [self.records addObject:record];
    [self reloadRecord];
}

-(float) CalCellHeight{
    UILabel* label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = SAMPLE_STRING;
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:label.font forKey:NSFontAttributeName] context:nil].size;
    return size.height;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [goodRecords count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"qiaonima" forIndexPath:indexPath];
    //refresh old data
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray<CALayer*>* AllLayer = cell.layer.sublayers;
    for(int i = 0; i < [AllLayer count]; i++){
        CALayer* Sublayer = AllLayer[i];
        if([Sublayer.name isEqualToString:@"AnimationLayer"]){
            [Sublayer removeFromSuperlayer];
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    cell.layer.cornerRadius = 5.0;
    //the last 2 item is empty
    if(indexPath.row<[goodRecords count]){
        UILabel* label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.text = [goodRecords[[goodRecords count]-indexPath.row-1] GetCellText];
        CGSize size = [label.text boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:label.font forKey:NSFontAttributeName] context:nil].size;
        label.frame = CGRectMake(10, 10, size.width, size.height);
        cell.layer.borderWidth = 1.0;
        [cell addSubview:label];
    }
    else{
        cell.layer.borderWidth = 0.0;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row<[goodRecords count]){
        Record* currentRecord = goodRecords[[goodRecords count]-indexPath.row-1];
      
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        
        [self.navigationController pushViewController:[[RecordVC alloc] initWithRecord: currentRecord] animated:NO];
    }
}

-(CAReplicatorLayer*) getLoadingAnimation:(UICollectionViewCell *)cell{
    float Width = cell.frame.size.width;
    float Height = cell.frame.size.height;
    float DotSize = 10;
    float DotGap = Width*0.05;
    int DotCount = 6;
    float DotStart = Width*0.5-DotGap*(DotCount*0.5-0.5)-DotSize*DotCount*0.5;
    float AnimateDuration = 0.35;
    
    CAReplicatorLayer* ReLayer = [CAReplicatorLayer layer];
    ReLayer.frame           = CGRectMake(0, 0, Width, Height);
    ReLayer.cornerRadius    = 10.0;
    ReLayer.backgroundColor = [UIColor whiteColor].CGColor;
    ReLayer.instanceCount = DotCount;
    ReLayer.instanceTransform = CATransform3DMakeTranslation(DotGap, 0, 0);
    ReLayer.instanceDelay = AnimateDuration/DotCount;
    ReLayer.name = @"AnimationLayer";
    
    CALayer *DotLayer        = [CALayer layer];
    DotLayer.frame           = CGRectMake(DotStart, ReLayer.frame.size.height/2, DotSize, DotSize);
    DotLayer.cornerRadius    = DotSize*0.5;
    DotLayer.backgroundColor = [UIColor grayColor].CGColor;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = AnimateDuration;
    animation.fromValue   = @1;
    animation.toValue     = @0;
    animation.repeatCount = MAXFLOAT;
    [DotLayer addAnimation:animation forKey:nil];
    
    [ReLayer addSublayer:DotLayer];
    return ReLayer;
}

-(void) deleteAnimation:(CAReplicatorLayer*) CurrentLayer{
    [CurrentLayer superlayer].borderWidth = 1.0;
    [CurrentLayer removeFromSuperlayer];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if(head<=tail && indexPath.row<queue[head]) queue[--head] = (int)indexPath.row;
    else queue[++tail] = (int)indexPath.row;
    float CurrentContentOffsetY = collectionView.contentOffset.y;
    if(CurrentContentOffsetY-eps>LastContentOffsetY && indexPath.row<[goodRecords count] && indexPath.row==queue[tail] && tail-head+1>=4){
        //NSLog(@"head = %d, tail = %d, current = %d\n",queue[head],queue[tail],(int)indexPath.row);
        CAReplicatorLayer* AnimationLayer = [self getLoadingAnimation: cell];
        [cell.layer addSublayer: AnimationLayer];
        cell.layer.borderWidth = 0;
        [self performSelector:@selector(deleteAnimation:) withObject: AnimationLayer afterDelay:0.5];
    }
    LastContentOffsetY = CurrentContentOffsetY;
}

-(void) collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==queue[head]) head++;
    else tail--;
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)newText{
    searchText = newText;
    [self reloadRecord];
    [self.displayTable reloadData];
}

-(bool) isGood:(NSString*)text record:(Record*)myRecord{
    NSString* matchText = [myRecord GetDetailText];
    int ptr = 0;
    for(int i = 0; i < matchText.length; i++){
        if(ptr<text.length && [text characterAtIndex:ptr]==[matchText characterAtIndex:i]){
            ptr++;
        }
    }
    if(ptr==text.length) return YES;
    else return NO;
}

-(void) reloadRecord{
    goodRecords = [[NSMutableArray alloc] init];
    for(int i = 0; i < [self.records count]; i++){
        if([self isGood:searchText record:self.records[i]]){
            [goodRecords addObject: self.records[i]];
        }
    }
}

-(float) CalTextHeight: (NSString*)text Width:(float) width{
    UILabel* label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = text;
    label.font = [UIFont systemFontOfSize:FONT_SIZE];
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:label.font forKey:NSFontAttributeName] context:nil].size;
    return size.height;
}

@end
