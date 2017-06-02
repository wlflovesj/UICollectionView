//
//  WLFHTTP.h
//  WLFProject
//
//  Created by wanglongfei on 2017/5/22.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLFHTTP : NSObject
+(id)shareIntance;
-(void)getDataWithURL:(NSString *)url type:(NSString *)type result:(void(^)(id data,NSError *error))result ;
@end
