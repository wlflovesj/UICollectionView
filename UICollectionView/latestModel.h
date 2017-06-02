//
//  latestModel.h
//  WLFProject
//
//  Created by wanglongfei on 2017/5/23.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface latestModel : NSObject
@property(strong,nonatomic)NSMutableArray *stories;
@property(strong,nonatomic)NSMutableArray *top_stories;
@property(strong,nonatomic)NSString *date;
@end
@interface Stories : NSObject
@property(copy,nonatomic)NSArray *images;
@property(copy,nonatomic)NSNumber *type;
@property(copy,nonatomic)NSNumber *Id;
@property(copy,nonatomic)NSString *ga_prefix;
@property(copy,nonatomic)NSString *title;
@end
@interface Top_stories : NSObject
@property(copy,nonatomic)NSString *image;
@property(copy,nonatomic)NSNumber *type;
@property(copy,nonatomic)NSNumber *Id;
@property(copy,nonatomic)NSString *ga_prefix;
@property(copy,nonatomic)NSString *title;
@end
