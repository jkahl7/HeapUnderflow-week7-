//
//  SearchQuestionsViewController.h
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/16/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BurgerDelegate.h"

@interface SearchQuestionsViewController : UIViewController

//TODO: be sure to pass the BurgerContainerCont
@property (weak, nonatomic) id<BurgerDelegate> delegate;

@end
