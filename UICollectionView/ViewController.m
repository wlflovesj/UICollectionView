//
//  ViewController.m
//  UICollectionView
//
//  Created by wanglongfei on 2017/5/31.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

#import "ViewController.h"
#import "TopScrollView.h"
#import "testViewController.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,assign)NSInteger oldIndex;
@property(nonatomic,strong)NSMutableDictionary<NSString *,UIViewController*> *childVcsdic;
@property(nonatomic,assign)BOOL forbidTouchToAdjustPosition;
@end

@implementation ViewController
{
    NSInteger _oldOffSetx;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    [self createUI];
    _oldOffSetx=0;
    _currentIndex=0;
    _oldIndex=-1;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.childVcsdic=[NSMutableDictionary dictionary];
    TopScrollView *top=[[TopScrollView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    top.tag=1000;
    [self.view addSubview:top];
     UICollectionView *collect=[self.view viewWithTag:100];
    top.buttonclick=^(NSInteger index){
        self.forbidTouchToAdjustPosition=YES;
        _currentIndex=index;
        [collect setContentOffset:CGPointMake(index*collect.frame.size.width, 0) animated:NO];
        
        
    };
    top.titleAry=@[@"新闻头条",
                   @"国际要闻",
                   @"体育",
                   @"中国足球",
                   @"汽车",
                   @"囧途旅游",
                   @"幽默搞笑",
                   @"视频",
                   @"无厘头",
                   @"美女图片",
                   @"今日房价",
                   @"头像"];
    
  }
-(void)createUI{
  
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-64);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) collectionViewLayout:layout];
    collection.delegate=self;
    collection.dataSource=self;
    collection.pagingEnabled=YES;
    collection.showsHorizontalScrollIndicator=NO;
    collection.bounces=NO;
    collection.tag=100;
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collection];


}
#pragma mark-UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 12;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{

    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  cell.contentView.backgroundColor=[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.5];
   
    return cell;


}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

    if (_currentIndex!=indexPath.row) {
        return;
    }
    UIViewController *currentVc=[_childVcsdic valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    NSLog(@"即将显示%ld",indexPath.row);
    if (currentVc==nil) {
        testViewController *t=[[testViewController alloc]init];
        t.view.frame=cell.contentView.frame;
        [cell.contentView addSubview:t.view];
        [_childVcsdic setValue:t forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        [self addChildViewController:t];
        [t didMoveToParentViewController:self];
    }
     currentVc.view.frame=cell.contentView.frame;
     [cell.contentView addSubview:currentVc.view];
    
    
    

}

#pragma mark-scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.forbidTouchToAdjustPosition=NO;
    if (scrollView.tag==100) {
        _oldOffSetx = scrollView.contentOffset.x;
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView.tag==100) {
        
        self.selectIndex=scrollView.contentOffset.x/self.view.frame.size.width;
        
        TopScrollView *tops=[self.view viewWithTag:1000];
        tops.selectIndex=self.selectIndex;
        
    }

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.forbidTouchToAdjustPosition) {
        return;
    }
    CGFloat tempProgress = scrollView.contentOffset.x / self.view.bounds.size.width;
    NSInteger tempIndex = tempProgress;
    
    CGFloat progress = tempProgress - floor(tempProgress);
    CGFloat deltaX = scrollView.contentOffset.x - _oldOffSetx;
    TopScrollView *tops=[self.view viewWithTag:1000];
        if (deltaX > 0) {// 向左
        if (progress == 0.0) {
            return;
        }
        _currentIndex = tempIndex+1;
        _oldIndex = tempIndex;
    }
    else if (deltaX < 0) {
        progress = 1.0 - progress;
        _oldIndex = tempIndex+1;
        _currentIndex = tempIndex;
        
    }
    else {
        return;
    }

    [tops TopscrollDidMoveFromIndex:_oldIndex toIndex:_currentIndex progress:progress];
    
    
    

}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
