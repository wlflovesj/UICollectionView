//
//  TopScrollView.h
//  UICollectionView
//
//  Created by wanglongfei on 2017/5/31.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef void(^OnButtonClickBlock)(NSInteger);
@interface TopScrollView : UIView
@property(nonatomic,copy)NSArray *titleAry;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,copy)OnButtonClickBlock buttonclick;
-(void)TopscrollDidMoveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;
@end
