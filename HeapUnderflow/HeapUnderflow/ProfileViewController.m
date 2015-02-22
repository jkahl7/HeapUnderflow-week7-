//
//  ProfileViewController.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/18/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "ProfileViewController.h"
#import "StackOverflowService.h"
#import "User.h"
#import "Constants.h"

@interface ProfileViewController () <UIScrollViewDelegate>

@property (retain, nonatomic) UIScrollView *scrollView;
@property (retain, nonatomic) UIImageView *imageView;
@property (retain, nonatomic) UILabel *userName;

@end

@implementation ProfileViewController

- (UILabel *)userName
{
  if (!_userName)
  {
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, LABELWIDTH, LABELWIDTH)];
  }
  return _userName;
}


- (void)viewDidLoad
{
  [super viewDidLoad];


  [[StackOverflowService sharedService] fetchUserProfile:^(User *userInfo, NSString *errorString) {
    self.userName.text = userInfo.userName;
    NSLog(@"%@", userInfo);
  }];
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
  self.scrollView.contentSize = CGSizeMake(1000, self.view.frame.size.width);
  self.scrollView.backgroundColor = [UIColor redColor];
  
  [self.view addSubview:self.scrollView];
  [self.view addSubview:self.userName];
  
  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
  self.imageView.image = [UIImage imageNamed:@"canhaz"];
  [self.scrollView addSubview:self.imageView];
  
}


-(void)dealloc
{
  [self.imageView release];
  [self.scrollView release];
  [self.userName release];
  [super dealloc];
}

@end
