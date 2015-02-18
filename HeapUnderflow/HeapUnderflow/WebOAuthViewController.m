//
//  WebOAuthViewController.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/16/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "WebOAuthViewController.h"
#import <WebKit/WebKit.h>
#import "Constants.h"

@interface WebOAuthViewController () <WKNavigationDelegate>



@end

@implementation WebOAuthViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  
  WKWebView *webView         = [[WKWebView alloc] initWithFrame:self.view.frame];
  webView.navigationDelegate = self;
  
  NSString *urlString = URL;
  urlString = [urlString stringByAppendingString:CLIENTID];
  urlString = [urlString stringByAppendingString:OAUTHSCOPE];
  urlString = [urlString stringByAppendingString:REDIRECTURI];

  NSURL *url = [[NSURL alloc] initWithString:urlString];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

  [webView loadRequest:urlRequest];
  [self.view addSubview:webView];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
  NSURLRequest *request = navigationAction.request;
  NSURL *url = request.URL;
  
  if ([url.description containsString:@"access_token"])
  {
    [webView removeFromSuperview];
    decisionHandler(WKNavigationActionPolicyAllow);
    
    NSArray *components = [[url description] componentsSeparatedByString:@"="];
    NSLog(@"%@",[components description]);
    NSString *token = components[1];
    
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:true completion:nil];
  
  } else {
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"access_token NOT recieved");
  }
}


@end




