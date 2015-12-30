//
//  TYCollectionViewCell.h
//  Unity-iPhone
//
//  Created by tangjp on 15/12/10.
//
//

#import <UIKit/UIKit.h>
#import "FurnitureModel.h"

@interface TYCollectionViewCell : UICollectionViewCell

@property (nonatomic ,assign) NSInteger price;
@property (nonatomic ,assign) NSInteger sales;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *imageName;
@property (nonatomic ,strong) FurnitureModel *furniture;
@end
