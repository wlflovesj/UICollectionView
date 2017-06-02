//
//  TopScrollView.m
//  UICollectionView
//
//  Created by wanglongfei on 2017/5/31.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

#import "TopScrollView.h"
#define FONTSIZE 15
#define XGAP 5
#define TITLEGAP 10
@interface TopScrollView ()<UIScrollViewDelegate>
@property(nonatomic,copy)NSMutableArray *titleFrameAry;
@property(nonatomic,copy)NSMutableArray *titleLabelAry;
@end

@implementation TopScrollView
{

    UIScrollView *_TopScroll;
    NSInteger _oldIndex;
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self=[super initWithFrame:frame]) {
        _titleFrameAry=[NSMutableArray array];
        _titleLabelAry=[NSMutableArray array];
        _TopScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_TopScroll];
        _TopScroll.delegate=self;
        _oldIndex=0;
        
        
    }
    
    return self;

}
-(void)setTitleAry:(NSArray *)titleAry
{
    _titleAry=titleAry;
   
    [self createUI];


}
-(void)TopscrollDidMoveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress{

    if (fromIndex < 0 ||
       fromIndex >= self.titleAry.count ||
        toIndex < 0 ||
        toIndex >= self.titleAry.count
        ) {
        return;
    }
    _oldIndex=toIndex;
    
    UILabel *oldlabel=_titleLabelAry[fromIndex];
    UILabel *currentlabel=_titleLabelAry[toIndex];
    oldlabel.textColor=[UIColor colorWithRed:1-progress green:0 blue:0 alpha:1];
    currentlabel.textColor=[UIColor colorWithRed:progress green:0 blue:0 alpha:1];
    oldlabel.transform=CGAffineTransformMakeScale(1+0.2*(1-progress), 1+0.2*(1-progress));
    currentlabel.transform=CGAffineTransformMakeScale(1+(0.2*progress), 1+(0.2*progress));


}
-(void)setSelectIndex:(NSInteger)selectIndex
{
    
    _selectIndex=selectIndex;
    [self scrollwithselectIndex:selectIndex];

}
-(void)createUI{

    CGFloat widthx = 0.0;
    for (int i=0; i<_titleAry.count; i++) {
        
        
        UILabel *label=[[UILabel alloc]init];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=_titleAry[i];
        label.font=[UIFont systemFontOfSize:FONTSIZE];
        CGRect bounds = [_titleAry[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONTSIZE]} context:nil];
        label.tag=100+i;
        label.frame=CGRectMake(widthx+XGAP, 7, bounds.size.width, 30);
        [_titleFrameAry addObject:[NSString stringWithFormat:@"%f",widthx+XGAP]];
        [_titleLabelAry addObject:label];
        widthx+=bounds.size.width+TITLEGAP;
        [_TopScroll addSubview:label];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelOnTap:)];
        [label addGestureRecognizer:tap];
        if (i==0) {
            label.textColor=[UIColor redColor];
            label.transform=CGAffineTransformMakeScale(1.2, 1.2);
            
        }
        label.userInteractionEnabled=YES;
    }
  
    _TopScroll.contentSize=CGSizeMake(widthx+XGAP, 0);
}
-(void)labelOnTap:(UITapGestureRecognizer *)tap{

    
    [self scrollwithselectIndex:tap.view.tag-100];
    
    if (_oldIndex==tap.view.tag-100) {
        
        
    }else{
        
        
        CGFloat animatedTime = 0.30 ;
        
        [UIView animateWithDuration:animatedTime animations:^{
            
            UILabel *oldlabel=_titleLabelAry[_oldIndex];
            UILabel *currentlabel=_titleLabelAry[tap.view.tag-100];
            oldlabel.transform=CGAffineTransformMakeScale(1, 1);
            currentlabel.transform=CGAffineTransformMakeScale(1.2, 1.2);
            
            
        } completion:^(BOOL finished) {
              _oldIndex=tap.view.tag-100;
        }];
    }
    
  

}

-(void)scrollwithselectIndex:(NSUInteger)currentIndex{

    
   
    for (UILabel *lab in _titleLabelAry) {
        
        if (currentIndex+100==lab.tag) {
            lab.textColor=[UIColor redColor];
        }else{
            
            lab.textColor=[UIColor blackColor];
        }
        
    }
    if (self.buttonclick) {
        self.buttonclick(currentIndex);
    }
    
    
    
    
    if ([_titleFrameAry[currentIndex] floatValue]>_TopScroll.contentSize.width-self.frame.size.width/2) {
          [_TopScroll setContentOffset:CGPointMake(_TopScroll.contentSize.width-self.frame.size.width, 0) animated:YES];
    }
    if ([_titleFrameAry[currentIndex] floatValue]<=self.frame.size.width/2) {
        
        [_TopScroll setContentOffset:CGPointMake(0, 0) animated:YES];

    }
    

    if ([_titleFrameAry[currentIndex] floatValue]>self.frame.size.width/2&&[_titleFrameAry[currentIndex] floatValue]<=_TopScroll.contentSize.width-self.frame.size.width/2) {//需要滚动
         CGRect bounds = [_titleAry[currentIndex] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:
                                                                                                                                                                [UIFont systemFontOfSize:FONTSIZE]} context:nil];
        CGFloat centerx=bounds.size.width/2+[_titleFrameAry[currentIndex] floatValue];
        CGFloat offsetx=centerx-self.frame.size.width/2;
        [_TopScroll setContentOffset:CGPointMake(offsetx, 0) animated:YES];
        
    }


}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
