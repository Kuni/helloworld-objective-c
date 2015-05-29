//
//  CRFastImagePickerViewController.m
//  helloworld-objective-c
//
//  Created by CHENHSIN-PANG on 2015/5/29.
//  Copyright (c) 2015年 CinnamonRoll. All rights reserved.
//

#import "CRFastImagePickerViewController.h"
#import "CRPhotoCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface CRFastImagePickerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, weak)UICollectionView *collectionView;
@property(nonatomic, strong)NSArray         *assets;
@property(nonatomic, assign)NSInteger       counts;
@property(nonatomic, strong)ALAssetsGroup   *group;

@end

@implementation CRFastImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    
    //
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource  = self;
    collectionView.delegate = self;
    
    
    [collectionView registerClass:[CRPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCell"];
    collectionView.alwaysBounceHorizontal = YES;

    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    self.view.backgroundColor = [UIColor whiteColor];

    ALAssetsLibrary *al = [[ALAssetsLibrary alloc] init];
    [al enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        NSLog(@"name = %@", [group valueForProperty:ALAssetsGroupPropertyName]);
        
        NSLog(@"count = %d", group.numberOfAssets);
        
        if([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"My Photo Stream"])
        {
            self.group = group;
            [self loadPhotoWithPage:1];
            *stop = YES;
        }
        
        
    
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    
    
    
     
     
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.view.frame);

    self.collectionView.frame = CGRectMake(0, 0, width, 150);
    //self.collectionView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
}


#pragma mark - Collection Data Source
// 這個應該要移到別的地方寫
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CRPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    cell.imageView.image = [self.assets objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}


//-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

// CollectionView Style
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //return CGSizeMake(150, 180);
    return CGSizeMake(200, 150);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    //return (int)((CGRectGetWidth(self.collectionView.frame) - 2*100)/3);
    return 0.0f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    //return 20;
    return 3;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat margin = (CGRectGetWidth(self.collectionView.frame) - 2*100)/3;
    //return UIEdgeInsetsMake(margin, margin, margin, margin);
    return UIEdgeInsetsZero;
}



//

-(void)loadPhotoWithPage:(NSInteger)page
{
    
    NSMutableArray *massets = [[NSMutableArray alloc] init];

    
    
    [self.group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if(result) {
            NSLog(@"index = %d", index);
            // result is your needed last asset
            [massets addObject:[UIImage imageWithCGImage:result.thumbnail]];
            self.assets = [massets copy];
            
//            if(index == self.group.numberOfAssets - 30)
//            {
//                *stop = YES;
//                [self.collectionView reloadData];
//            }
            
            if(index % 30 == 0)
            {
                [self.collectionView reloadData];
            }


            
            
        }
        
    }];


}


@end
