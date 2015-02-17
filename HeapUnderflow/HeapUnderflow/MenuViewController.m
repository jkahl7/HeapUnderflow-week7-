//
//  MenuViewController.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/16/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "MenuViewController.h"
#import "WebOAuthViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults stringForKey:@"token"];
  
  if (!token)
  {
    WebOAuthViewController *webOAuthVC = [[WebOAuthViewController alloc] init];
    
    [self presentViewController:webOAuthVC animated:true completion:^{
      NSLog(@"inside the block");
    }];
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.delegate menuOptionSelected:indexPath.row];
}

@end
