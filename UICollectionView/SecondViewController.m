//
//  SecondViewController.m
//  UICollectionView
//
//  Created by wanglongfei on 2017/6/1.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor cyanColor];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 20, 40, 50);
    [button setTitle:@"fanhui" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onbutton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.

    
    NSString *str = @"dfdf";
    NSString *str4 = @"dfdfaaaa";

}
-(void)onbutton{

    NSLog(@"%@",self.navigationController);
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
