//
//  AnswerViewController.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/20/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "AnswerViewController.h"

@interface AnswerViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation AnswerViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.activityIndicator isAnimating];
  self.activityIndicator.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
  NSURL *url = [NSURL URLWithString:self.answerURL];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [self.webView loadRequest:request];
  self.activityIndicator.hidden = YES;
}




@end
