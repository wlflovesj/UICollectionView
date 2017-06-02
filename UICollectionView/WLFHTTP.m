//
//  WLFHTTP.m
//  WLFProject
//
//  Created by wanglongfei on 2017/5/22.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

#import "WLFHTTP.h"
#import <MJExtension.h>
#import "latestModel.h"

@implementation WLFHTTP

+(id)shareIntance{

    
    static WLFHTTP *wl=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wl=[[WLFHTTP alloc]init];
        
    });

    return wl;
}
-(void)getDataWithURL:(NSString *)url type:(NSString *)type result:(void (^)(id, NSError *))result {


    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",response);
        
        if (error) {
            return ;
        }
        NSDictionary *di=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
       
        latestModel *mo=[latestModel mj_objectWithKeyValues:di];

        
        
        if (result) {
            
            result(mo,error);
        }
        
    }];
    
    
    [task resume];



}
@end
