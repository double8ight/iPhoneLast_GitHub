//
//  ViewController.m
//  day17_11p_pushNotification
//
//  Created by SDT-1 on 2014. 1. 20..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)notiNow:(id)sender;
- (IBAction)fireNoti:(id)sender;
- (IBAction)fireNotiIn7:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)notiNow:(id)sender {
    
    UILocalNotification *noti = [[UILocalNotification alloc]init];
    noti.alertBody = @"노티 테스트";
    noti.alertAction = @"확인";
    
    // 알림창은 안나타나지만 AppDelegate의 메소드는 실행됨
    [[UIApplication sharedApplication]presentLocalNotificationNow:noti];
    
}

- (IBAction)fireNoti:(id)sender {
    
    UILocalNotification *noti = [[UILocalNotification alloc]init];
    noti.alertBody = @"지정 시간 알림";
    noti.alertAction = @"확인";
    noti.fireDate = self.datePicker.date;
    
    // 30초 이내의 사운드
    noti.soundName = @"timer.mp3";
    
    // 앱 구동시 잠시 나타나는 런처 이미지
    noti.alertLaunchImage = @"timer.jpg";
    
    noti.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"object", @"key", nil];
    
    [[UIApplication sharedApplication]scheduleLocalNotification:noti];
    
}

- (IBAction)fireNotiIn7:(id)sender {
    
    UILocalNotification *noti = [[UILocalNotification alloc]init];
    noti.alertBody = @"7 seconds";
    noti.alertAction = @"확인";
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:7];
    noti.soundName = UILocalNotificationDefaultSoundName;
    
    noti.userInfo = nil;
    [[UIApplication sharedApplication]scheduleLocalNotification:noti];
    
    
}
@end
