//
//  ViewController.m
//  day18_86p_facebookStream
//
//  Created by SDT-1 on 2014. 1. 21..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

#define FACEBOOK_APPID @"607018306013290"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ACAccount *facebookAccount;
@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) IBOutlet UITableView *table;


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


-(void)showTimeline
{
    // 계정 정보를 담은 스토어 객체 생성
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    
    // 페이스북의 계정 타입
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    // 앱 아이디와 권한 지정
    NSDictionary *options = @{ACFacebookAppIdKey:FACEBOOK_APPID,
                              ACFacebookPermissionsKey:@[@"basic_info"],
                              ACFacebookAudienceKey:ACFacebookAudienceEveryone};
    
    // 계정과 권한에 대한 승인 요청
    [accountStore requestAccessToAccountsWithType:accountType options:options completion:^(BOOL granted, NSError *error) {
        
        if(error)
            NSLog(@"ERROR : %@", error);
        if(granted)
        {
            // 승인 성공
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            self.facebookAccount = [accounts lastObject];
            
            [self requestFeed];
            
        }
        else
        {
            NSLog(@"승인 실패 : %@", error);
        }
    }];
    
    
}


-(void)requestFeed
{
    // 그래프 API를 적용한 URL
    NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/me/friends"];
    
    // parameters
    NSDictionary *params = nil;
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:url parameters:params];
    request.account = self.facebookAccount;
    
    
    // 페이스북 서비스에 요청을 수행한다. 핸들러를 이용해서 요청의 결과를 처리한다.
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if(error != nil)
        {
            NSLog(@"프로필 정보 얻기 실패 : %@", error);
            return;
        }
        
        
        // 요청 결과를 처리하기 위한 코드 작성
        __autoreleasing NSError *parseError;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&parseError];
        
        self.data = result[@"data"];
        
        // 메인스레드에서 화면 업데이트
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.table reloadData];
        }];
        
        
        
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FEED_CELL"];
    
    //NSDictionary *one = self.data[indexPath.row];
    
    cell.textLabel.text = self.data[indexPath.row][@"name"];
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self showTimeline];
}


@end
