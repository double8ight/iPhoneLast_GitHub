//
//  AppDelegate.m
//  APNTest
//
//  Created by SDT-1 on 2014. 1. 20..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation AppDelegate
{
    NSMutableDictionary *_messages;
}


// 앱이 실행중이거나 아닐 때 푸시를 다 받는다.
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"remote notification : %@", [userInfo description]);
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    
    NSString *alert = [apsInfo objectForKey:@"alert"];
    NSLog(@"Received Push Alert : %@", alert);
    
    NSString *sound = [apsInfo objectForKey:@"sound"];
    NSLog(@"Received Push sound : %@", sound);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    NSString *badge = [apsInfo objectForKey:@"badge"];
    NSLog(@"Received Push badge : %@", badge);
    application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"]integerValue];
    
    UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"알림 발송" message:alert delegate:nil cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
    [alert2 show];
    
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"success to register APN : %@", deviceToken);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"fail to register APN : %@", [error localizedDescription]);
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // 노티 종류
    UIRemoteNotificationType notiType = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    
    // 토큰 요청
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:notiType];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
