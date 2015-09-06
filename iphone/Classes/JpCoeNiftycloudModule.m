/**
 * niftycloud
 *
 * Created by Your Name
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "JpCoeNiftycloudModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
//#import "NCMBWrapper.h"


@implementation JpCoeNiftycloudModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"f652d945-9121-4ee7-a2ff-ca51e4be9c05";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"jp.coe.niftycloud";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}

//-(void)increment:(id)args
//{
//    NSString* className = [args objectAtIndex:0];
//    NSString* whereKey = [args objectAtIndex:1];
//    NSString* equalTo = [args objectAtIndex:2];
//    NSString* countKey = [args objectAtIndex:3];
//    KrollCallback* callback = [args objectAtIndex:4];
//    
//    [NCMBWrapper increment:className whereKey:whereKey equalTo:equalTo countKey:countKey WithBlock:^(NSError *error) {
//        NSArray* arr;
//        if(error) {
//            arr = @[@NO];
//        } else {
//            arr = @[@YES];
//        }
//        [callback call:arr thisObject:nil];
//    }];
//}

@end
