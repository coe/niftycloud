//
//  NCMBWrapper.m
//  million
//
//  Created by COFFEE on 2015/08/28.
//  Copyright (c) 2015年 COFFEE. All rights reserved.
//

#import "NCMBWrapper.h"
#import "NCMB.h"

@implementation NCMBWrapper

+(void)start:(NSString*)applicationKey clientKey:(NSString*)clientKey
{
    NSLog(@"%s%d",__func__,__LINE__);
    [NCMB setApplicationKey:applicationKey clientKey:clientKey];
}

+(void)incrementKey:(NSString*)className key:(NSString*)key callback:(void (^)(NSError *error))callback
{
    NSLog(@"%s%d",__func__,__LINE__);
    NCMBObject *post = [NCMBObject objectWithClassName:className];
    [post incrementKey:key];
    [post saveInBackgroundWithBlock:callback];
}

+(id)objectForKey:(NSString*)className key:(NSString*)key
{
    NSLog(@"%s%d",__func__,__LINE__);
    NCMBQuery *query = [NCMBQuery queryWithClassName:className];
    [query whereKey:@"author" equalTo:@"ncmb"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        for (NCMBObject *post in posts) {
            NSLog(@"%@", post);
            
            // objectForKeyアクセス
            NSString *author = [post objectForKey:@"author"];
            BOOL publication = [[post objectForKey:@"publication"] boolValue];
            
            NSLog(@"author:%@, publication:%@", author, publication ? @"YES" : @"NO");
            
            // プロパティアクセス
            NSString *objectId = post.objectId;
            NSDate *createdDate = post.createDate;
            NSDate *updatedDate = post.updateDate;
            NSLog(@"objectId: %@, updatedAt: %@, createdAt: %@", objectId, updatedDate, createdDate);
            
            // 再取得
            [post refresh:nil];
        }
    }];
    NCMBObject *post = [NCMBObject objectWithClassName:className];
    id pos = [post objectForKey:key];
    NSLog(@"%s%d %@",__func__,__LINE__,pos);
    return pos ;
}

+(void)setObject:(NSString*)className dictionary:(NSDictionary*)dictionary
{
    NSLog(@"%s%d",__func__,__LINE__);
    NCMBObject *post = [NCMBObject objectWithClassName:className];
    for (id key in [dictionary keyEnumerator]) {
        NSLog(@"Key:%@ Value:%@", key, [dictionary valueForKey:key]);
        //TODO:配列に対応するのは後日
        [post setObject:[dictionary valueForKey:key] forKey:key];

    }

    [post saveInBackgroundWithBlock:nil];
}

+(void)findObjects:(NSString*)className whereKey:(NSString*)whereKey equalTo:(NSString*)equalTo WithBlock:(void (^)(NSArray *posts, NSError *error))block
{
    NSLog(@"%s%d",__func__,__LINE__);
    NCMBQuery *query = [NCMBQuery queryWithClassName:className];
    
    [query whereKey:whereKey equalTo:equalTo];
    [query findObjectsInBackgroundWithBlock:block];

}

+(void)increment:(NSString*)className whereKey:(NSString*)whereKey equalTo:(NSString*)equalTo countKey:(NSString*)countKey WithBlock:(void (^)(NSError *error))block
{
    NSLog(@"%s%d",__func__,__LINE__);

    NCMBQuery *query = [NCMBQuery queryWithClassName:className];
    
    [query whereKey:whereKey equalTo:equalTo];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            block(error);
        } else {
            //ない場合はセット
            if(objects.count == 0) {
                [NCMBWrapper setObject:className dictionary:@{whereKey: equalTo,countKey:@1 }];
                
            } else {
                
                for (NCMBObject* post in objects) {
                    [post incrementKey:countKey];
                    [post saveInBackgroundWithBlock:^(NSError *error) {
                        if (error) {
                            block(error);
                        } else {
                            block(nil);
                        }
                    }];
                }
            }
        }

        
    }];
}

@end
