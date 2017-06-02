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
#import "NSString+Md5Encryption.h"
#import "WLFHTMLCache.h"
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

    
    if ([type isEqualToString:@"refresh"]) {
        
        [[WLFHTMLCache defaultCache] removeObjectForKey:[url Md5_Encryption]];
    }
//   NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [request setValue:@"\"b0093bb979a5ac9e2e30056c654e366d5c0dd093\"" forHTTPHeaderField:@"If-None-Match"];
//    
//    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
//        NSLog(@"%ld",(long)httpresponse.statusCode);
//        NSLog(@"%@",response);
//        
//    }];
    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",response);
        
        if (error) {
            return ;
        }
        NSDictionary *di=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
       
        latestModel *mo=[latestModel mj_objectWithKeyValues:di];
//        NSLog(@"%@,,%@,,,%@",mo.date,mo.stories,mo.top_stories);
//        for (Stories*st in mo.stories) {
//            
//            NSLog(@"%@,%@,%@,%@,%@",st.images,st.Id,st.title,st.type,st.ga_prefix);
//        }
        
        
        if (result) {
            
            result(mo,error);
        }
        
    }];
    
    
    [task resume];



}
@end
