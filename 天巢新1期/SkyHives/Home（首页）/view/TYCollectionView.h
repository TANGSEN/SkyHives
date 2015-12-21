//
//  TYCollectionView.h
//  Unity-iPhone
//
//  Created by tangjp on 15/12/10.
//
//

#import <UIKit/UIKit.h>

@protocol TYCollectionDelegate<NSObject> 
@optional
-(void)TY_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface TYCollectionView : UICollectionView <UICollectionViewDataSource , UICollectionViewDelegate>
+ (CGFloat)height;
@property(nonatomic,assign)id <TYCollectionDelegate>TY_delegate;
@property (nonatomic ,strong) NSArray *titles;
@end
