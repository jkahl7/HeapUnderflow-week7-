//
//  MenuViewController.h
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/16/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuDelegate.h"

@interface MenuViewController : UITableViewController

@property (weak, nonatomic) id<MenuDelegate> delegate;

@end
