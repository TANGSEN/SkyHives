//
//  TYTableView.h
//  Unity-iPhone
//
//  Created by tangjp on 15/12/9.
//
//

#import <UIKit/UIKit.h>

@protocol TYTableDelegate<NSObject>
@optional
-(void)TY_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface TYTableView : UITableView <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)id <TYTableDelegate>TY_delegate;
@property (nonatomic ,copy) NSString *sectionHeaderTitle;
@property (nonatomic ,assign) NSInteger cellCount;
@property (nonatomic ,strong) NSArray *images;
- (CGFloat)height;
@end
