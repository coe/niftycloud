/**
 * niftycloud
 *
 * Created by Your Name
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "TiModule.h"

@interface JpCoeNiftycloudModule : TiModule
{
}

/*
 mobile backend開始
 @param {String} ApplicationKey
 @param {String} ClientKey
 */
-(void)start:(id)args;

/*
 mobile backendでキーのインクリメント
 @param {String} ClassName
 @param {String} whereKey
 @param {String} equalTo
 @param {String} countKey
 @param {function} callback YES or NO
 */
-(void)increment:(id)args;


/*
 mobile backendでキーの取得
 @param {String} ClassName
 @param {String} whereKey
 @param {String} equalTo
 @param {String} key
 @param {function} callback
 */
-(void)findObject:(id)args ;

@end
