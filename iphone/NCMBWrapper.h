//
//  NCMBWrapper.h
//  million
//
//  Created by COFFEE on 2015/08/28.
//  Copyright (c) 2015年 COFFEE. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NCMBWrapper : NSObject

+(void)start:(NSString*)applicationKey clientKey:(NSString*)clientKey;
+(void)increment:(NSString*)className whereKey:(NSString*)whereKey equalTo:(NSString*)equalTo countKey:(NSString*)countKey WithBlock:(void (^)(NSError *error))block;
+(void)findObjects:(NSString*)className whereKey:(NSString*)whereKey equalTo:(NSString*)equalTo WithBlock:(void (^)(NSArray *posts, NSError *error))block;

@end
