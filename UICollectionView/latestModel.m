//
//  latestModel.m
//  WLFProject
//
//  Created by wanglongfei on 2017/5/23.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

#import "latestModel.h"
#import <MJExtension/MJExtension.h>



@implementation Stories

+(NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"Id":@"id"};


}

@end



@implementation Top_stories

+(NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"Id":@"id"};
    

}

@end




@implementation latestModel
MJExtensionCodingImplementation

+(NSDictionary *)mj_objectClassInArray{

    return @{@"stories" :@"Stories",@"top_stories":@"Top_stories"};

}
@end
