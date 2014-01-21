//
//  ViewController.m
//  day18_SDK_facebookFriendList
//
//  Created by SDT-1 on 2014. 1. 21..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController ()<FBLoginViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController
{
    NSArray *friends;
}

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        friends = [result objectForKey:@"data"];
        [self.table reloadData];
    }];
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    friends = nil;
    [self.table reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    friends = [[NSArray alloc]init];
    
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 50);
    loginView.delegate = self;
    [self.view addSubview:loginView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [friends count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRIEND_CELL" forIndexPath:indexPath];
    
    NSDictionary<FBGraphUser> *friendList;
    friendList = friends[indexPath.row];
    
    
    cell.textLabel.text = friendList.name;
    
    return cell;
}


@end
