#import <QuartzCore/QuartzCore.h>
#import "CreateVC.h"
#import "SubButton.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define FONT_SIZE 20

@implementation CreateVC{
    UITextView* textViews[4];
    Record* record;
    UIImagePickerController* imagePicker;
    UICollectionView* imageView;
    float imageSize;
}

-(id) init{
    record = [[Record alloc] init];
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    float BlankSpace = SCREEN_WIDTH*0.04;
    float LeftWidth = SCREEN_WIDTH*0.22;
    float RightWidth = SCREEN_WIDTH*0.66;
    float ItemWidth = SCREEN_WIDTH*0.28;
    float LineHeight = [self CalTextHeight:@" " Width:100];
    imageSize = ItemWidth;

    UILabel* label = [self GetLabel:@"时间\n\n地点\n\n景点名称\n\n心得\n\n\n\n\n\n图片" Width:LeftWidth beginX:BlankSpace beginY:BlankSpace*2];
    label.layer.borderWidth = 0;
    [self.view addSubview:label];
    
    for(int i = 0; i < 4; i++){
        float curWidth = i==3?RightWidth:RightWidth*0.6;
        float curHeight = i==3?LineHeight*6:LineHeight*1.2;
        textViews[i] = [[UITextView alloc] initWithFrame:CGRectMake(BlankSpace+LeftWidth, BlankSpace*2+i*2*LineHeight, curWidth, curHeight)];
        textViews[i].textContainer.maximumNumberOfLines = i==3?10:1;
        textViews[i].autocorrectionType = UITextAutocorrectionTypeNo;
        textViews[i].autocapitalizationType = UITextAutocapitalizationTypeNone;
        textViews[i].layer.borderColor = [UIColor grayColor].CGColor;
        textViews[i].layer.borderWidth = 1.0;
        [self.view addSubview:textViews[i]];
    }
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = BlankSpace;
    flowLayout.minimumInteritemSpacing = BlankSpace;
    flowLayout.itemSize = CGSizeMake(ItemWidth,ItemWidth);
    flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);

    imageView = [[UICollectionView alloc]
                 initWithFrame: CGRectMake(BlankSpace,BlankSpace*3+12*LineHeight+BlankSpace*2,SCREEN_WIDTH-2*BlankSpace,BlankSpace+2*ItemWidth)
                 collectionViewLayout:flowLayout];
    imageView.delegate = self;
    imageView.dataSource = self;
    imageView.backgroundColor = [UIColor whiteColor];
    [imageView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"qiaonima"];
    [self.view addSubview:imageView];
    
    SubButton* submitButton = [[SubButton alloc]initWithFrame:CGRectMake(BlankSpace*3+ItemWidth*2, BlankSpace*3+12*LineHeight+BlankSpace*2+BlankSpace+2*ItemWidth+BlankSpace*2, ItemWidth, ItemWidth*0.35)];
    submitButton.owner = self;
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    submitButton.layer.borderColor = [UIColor grayColor].CGColor;
    submitButton.layer.borderWidth = 1.0;
    [self.view addSubview: submitButton];
    self.navigationItem.title = @"添加打卡";
    return self;
}

-(void) onButtonClick:(SubButton*) currentButton{
    record.Date = textViews[0].text;
    record.Location = textViews[1].text;
    record.Name = textViews[2].text;
    record.Note = textViews[3].text;
    CreateVC* owner = (CreateVC*)currentButton.owner;
    [owner.MyDsicover addRecord: record];
    [owner.MyDsicover.displayTable reloadData];
    //clear
    record = [[Record alloc] init];
    for(int i = 0; i < 4; i++){
        textViews[i].text = @"";
        [textViews[i] reloadInputViews];
    }
    [imageView reloadData];
    //return & pop
    self.TabBarVC.selectedIndex = 0;
    [self.MyDsicover.navigationController popToRootViewControllerAnimated:YES];
    //display message
    //turn off, debug only
    
    UIAlertController* doneVC = [UIAlertController alertControllerWithTitle:@"Tip" message:@"Record added" preferredStyle:UIAlertControllerStyleAlert ];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [doneVC addAction: okAction];
    [self.TabBarVC presentViewController:doneVC animated:YES completion:nil];
}

-(float) CalTextHeight: (NSString*)text Width:(float) width{
    UILabel* label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = text;
    label.font = [UIFont systemFontOfSize:FONT_SIZE];
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
    //maximun image number is 6
    if([record->Images count]!=6){
        return [record->Images count]+1;
    }
    else{
        return [record->Images count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"qiaonima" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    if(indexPath.row==[record->Images count]){
        //addButton
        UIImage* image = [UIImage imageNamed:@"pic/images.png"];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0,0,imageSize,imageSize);
        cell.layer.borderWidth = 1.0;
        cell.layer.borderColor =[UIColor blackColor].CGColor;
        [cell addSubview:imageView];
    }
    else{
        //loadImage
        UIImageView* imageView = [[UIImageView alloc] initWithImage:record->Images[indexPath.row]];
        imageView.frame = CGRectMake(0,0,imageSize,imageSize);
        cell.layer.borderWidth = 0.0;
        [cell addSubview:imageView];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==[record->Images count]){
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [record->Images addObject:image];
    [imageView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
