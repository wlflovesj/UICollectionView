//
//  testViewController.m
//  UICollectionView
//
//  Created by wanglongfei on 2017/6/1.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

#import "testViewController.h"
#import "WLFHTTP.h"
#import "API.h"
#import "latestModel.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "SecondViewController.h"
@interface testViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    latestModel *_latestModel;
    
}


@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height-50) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableview];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 375, 30);
    [button setTitle:@"下载" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    _tableview.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        WLFHTTP *wl=[WLFHTTP shareIntance];
        
        [wl getDataWithURL:[NSString stringWithFormat:@"%@/latest",ZHIHUAPI] type:@"refresh" result:^(id data, NSError *error) {
            
            _latestModel=data;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableview reloadData];
                [_tableview.mj_header endRefreshing];
            });
            
            
        }];
        
        
    }];
    _tableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        
        [_tableview.mj_footer endRefreshing];
    }];
    

    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return _latestModel.stories.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 100;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondViewController *vc=[[SecondViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell"];
    Stories *s=_latestModel.stories[indexPath.row];

    cell.textLabel.text=s.title;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:s.images[0]] placeholderImage:[UIImage imageNamed:@"miaomiao.jpg"]];
    return cell;
}
-(void)buttonClick{
    
    WLFHTTP *wl=[WLFHTTP shareIntance];
    
    [wl getDataWithURL:[NSString stringWithFormat:@"%@/latest",ZHIHUAPI] type:@"" result:^(id data, NSError *error) {
        
        _latestModel=data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableview reloadData];
        });
        
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
