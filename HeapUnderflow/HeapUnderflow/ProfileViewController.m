//
//  ProfileViewController.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/18/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <UIScrollViewDelegate>

@property (retain, nonatomic) UIScrollView *scrollView;
@property (retain, nonatomic) UIImageView *imageView;
@end

@implementation ProfileViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
  self.scrollView.contentSize = CGSizeMake(1000, self.view.frame.size.width);
  self.scrollView.backgroundColor = [UIColor redColor];
  
  [self.view addSubview:self.scrollView];
  
  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
  self.imageView.image = [UIImage imageNamed:@"background0"];
  [self.scrollView addSubview:self.imageView];
  
}


-(void)dealloc
{
  [self.imageView release];
  [self.scrollView release];
  [super dealloc];
}

@end
