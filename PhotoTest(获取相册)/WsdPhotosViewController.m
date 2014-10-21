//
//  WsdPhotosViewController.m
//  PhotoTest
//
//  Created by sunlight on 14-7-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WsdPhotosViewController.h"
#import "WsdCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface WsdPhotosViewController ()

@property (nonatomic,strong) NSMutableArray *photos;

@property (nonatomic,strong) UICollectionViewController *collectionVC;

@property (nonatomic,strong) ALAssetsLibrary *library;

@property (nonatomic,strong) NSMutableArray *selectedRows;

@end

@implementation WsdPhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCustomView];
    // Do any additional setup after loading the view.
    [self loadPhotos];
    
}

- (void)createCustomView{
    
    //创建导航栏
    UIImageView *navigationView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 768.0, 64.0)];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置各单元格的大小
    flowLayout.itemSize = CGSizeMake(150, 150);
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 35, 20, 35);
    flowLayout.minimumLineSpacing = 20.0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionViewController *vc = [[UICollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    vc.collectionView.frame = CGRectMake(0.0, 64.0, 768.0, 960.0);
    vc.collectionView.delegate = self;
    vc.collectionView.dataSource = self;
    vc.collectionView.backgroundColor = [UIColor clearColor];
    [vc.collectionView registerClass:[WsdCollectionViewCell class] forCellWithReuseIdentifier:@"cellView"];
    self.collectionVC = vc;
    [self.view addSubview:vc.collectionView];
}

- (void)loadPhotos{
    self.selectedRows = [[NSMutableArray alloc] init];
    self.photos = [[NSMutableArray alloc] init];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    //保持引用，防止被释放导致错误
    self.library = library;
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       
                       @autoreleasepool {
                           // Group enumerator Block
                           void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
                           {
                               if (group == nil)
                               {
                                   return;
                               }
                               NSLog(@"%@",group);
                               [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                   if (result == nil) {
                                       return ;
                                   }
                                   [self.photos addObject:result];
                               }];
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [self.collectionVC.collectionView reloadData];
                               });

                           };
                           
                           // Group Enumerator Failure Block
                           void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                               
                               UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"操作失败，未授权访问" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                               [alert show];
                               
                               NSLog(@"A problem occured %@", [error description]);
                           };
                           
                           //枚举照片库
                           [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                                  usingBlock:assetGroupEnumerator
                                                failureBlock:assetGroupEnumberatorFailure];
                       };
                   });
    

}

#pragma mark datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.photos count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *IDENTIFY = @"cellView";
    WsdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFY forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1401];
    ALAsset *asset = self.photos[indexPath.row];
    NSLog(@"%@",asset.thumbnail);
    imageView.image = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    
    UIImageView *selectedImageView = (UIImageView *)[cell viewWithTag:1402];
    selectedImageView.tag = 1402;
    if ([self.selectedRows containsObject:[NSNumber numberWithInt:indexPath.row]]) {
        selectedImageView.hidden = NO;
    }else{
        selectedImageView.hidden = YES;
    }
    
    return cell;
}

#pragma mark delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WsdCollectionViewCell *cell = (WsdCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *selectedImageView = (UIImageView *)[cell viewWithTag:1402];
    if ([self.selectedRows containsObject:[NSNumber numberWithInt:indexPath.row]]) {
        selectedImageView.hidden = YES;
        [self.selectedRows removeObject:[NSNumber numberWithInt:indexPath.row]];
    }else{
        selectedImageView.hidden = NO;
        [self.selectedRows addObject:[NSNumber numberWithInt:indexPath.row]];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
