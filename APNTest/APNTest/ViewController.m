//
//  ViewController.m
//  APNTest
//
//  Created by SDT-1 on 2014. 1. 20..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#define FRIEND_LIST @"http://192.168.211.166:3000/friend_list.json"
#define PROVIDER_ADDRESS @"http://192.168.211.166:3000"

@interface ViewController ()
{
    NSArray *friendList;
    int selectedRow;
}


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


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //알림창 확인 버튼
    if(alertView.firstOtherButtonIndex == buttonIndex)
    {
        
        //프로바이더로 정보 보내기 위한 주소
        NSString *msg = [alertView textFieldAtIndex:0].text;
        NSString *name = [[friendList objectAtIndex:selectedRow]objectForKey:@"name"];
        NSString *urlStr = [NSString stringWithFormat:@"%@?msg=%@&name=%@",PROVIDER_ADDRESS, msg, name];
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"urlStr : %@", urlStr);
        
        //URL과 Request
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // 프로바이더로 전송
        __autoreleasing NSError *error = nil;
        NSURLResponse *response = nil;
        NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *resultStr = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
        
        NSLog(@"Result : %@", resultStr);
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [friendList count];
}

// JSON에서 이름으로 셀 표시
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    NSDictionary *one = [friendList objectAtIndex:indexPath.row];
    cell.textLabel.text = [one objectForKey:@"name"];
    return cell;
}

// 악세서리 버튼을 이용해서 alertview 표시
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"알림 발송" message:@"알림 메시지" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    selectedRow = indexPath.row;
    [alert show];
}

// 서버의 JSON에서 친구 목록을 불러온다.
-(void)parseFriendList
{
    NSURL *url = [NSURL URLWithString:FRIEND_LIST];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    __autoreleasing NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    friendList = [result objectForKey:@"friends"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self parseFriendList];
}

@end
