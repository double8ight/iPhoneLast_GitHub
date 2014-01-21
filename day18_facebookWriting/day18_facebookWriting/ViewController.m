//
//  ViewController.m
//  day18_facebookWriting
//
//  Created by SDT-1 on 2014. 1. 21..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()
- (IBAction)showSocialComposer:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"http://www.facebook.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showSocialComposer:(id)sender {
    NSString *service = SLServiceTypeFacebook;
    
    // 페이스북에 글 작성이 가능한가?
    if([SLComposeViewController isAvailableForServiceType:service])
    {
        //페이스북에 글을 작성하기 위한 뷰 컨트롤러 생성
        SLComposeViewController *composer = [SLComposeViewController composeViewControllerForServiceType:service];
        
        // 글 작성시 초기에 입력될 이미지와 글
        UIImage *image = [UIImage imageNamed:@"image.png"];
        [composer addImage:image];
        
        [composer setInitialText:@"소셜 프레임워크를 이용한 글 쓰기 테스트"];
        
        composer.completionHandler = ^(SLComposeViewControllerResult result)
        {
            if(SLComposeViewControllerResultDone == result)
                NSLog(@"글 작성 완료");
            else
                NSLog(@"글 작성 취소");
            
        };
        
        // 모달로 표시
        [self presentViewController:composer animated:YES completion:nil    ];
    }
}
@end
