//
//  BurgerContainerController.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/16/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "BurgerContainerController.h"
#import "MenuViewController.h"
#import "MenuDelegate.h"

//TODO: make this an enum in the header file - preprocesser directives are frowned upon
#define BURGERLOC 5            //burgerButton icon's location
#define BURGERSIZE 50           //burgerButton icon's height + width
#define ANIMATIONDURATION 0.3   //animateWithDuration's animation time

@interface BurgerContainerController () <MenuDelegate>


@property (strong, nonatomic) UINavigationController *SearchVC;

@property (strong, nonatomic) UIViewController *topViewController;

@property (strong, nonatomic) UIGestureRecognizer *tapToCloseRecognizer;

@property (strong, nonatomic) UIPanGestureRecognizer *slideRecognizer;

@property (strong, nonatomic) UIButton *burgerButton;


@end

@implementation BurgerContainerController

#pragma Lazy instantiation of properties
- (UINavigationController *)SearchVC
{
  if (!_SearchVC)
  {
    _SearchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
  }
  return _SearchVC;
}

- (UIButton *)burgerButton
{
  if (!_burgerButton)
  {
    _burgerButton = [[UIButton alloc] initWithFrame:CGRectMake(BURGERLOC, BURGERLOC, BURGERSIZE, BURGERSIZE)];
  }
  return _burgerButton;
}

- (UIGestureRecognizer *)tapToCloseRecognizer
{
  if(!_tapToCloseRecognizer)
  {
    _tapToCloseRecognizer = [[UIGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(tapToClose)];
  }
  return _tapToCloseRecognizer;
}

- (UIPanGestureRecognizer *)slideRecognizer
{
  if (!_slideRecognizer)
  {
    _slideRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(slideTopVC:)];
  }
  return _slideRecognizer;
}



- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //manually adding a childVC to the screen -> same as using container view + embed segue in SB
  // step 1
  [self addChildViewController:self.SearchVC];
  // step 2 add a frame
  self.SearchVC.view.frame = self.view.frame;
  // step 3 add our new child view to our burger's view
  [self.view addSubview:self.SearchVC.view];
  // step 4 Called after the view controller is added or removed from a containerVC.
  [self.SearchVC didMoveToParentViewController:self];
  
  
  self.topViewController = self.SearchVC;
  
  [self.burgerButton setBackgroundImage: [UIImage imageNamed:@"hamburger"] forState:UIControlStateNormal];
  
  [self.view addSubview:self.burgerButton];
  
  //ensures that the present VC is the target of the burgerButtonClicked method
  [self.burgerButton addTarget:self
                        action:@selector(burgerButtonClicked)
              forControlEvents:UIControlEventTouchUpInside];
  
  [self.topViewController.view addGestureRecognizer:self.slideRecognizer];
}


#pragma burgerButtonClicked
- (void)burgerButtonClicked
{
  //NSLog(@"burger selected om nom nom");
  self.burgerButton.userInteractionEnabled = false;
  
  __weak BurgerContainerController *weakSelf = self;
  
  //struct for digging into the weakSelf view properties
  CGPoint tempCenter = weakSelf.topViewController.view.center;
  
  [UIView animateWithDuration:ANIMATIONDURATION animations:^{
    weakSelf.topViewController.view.center = CGPointMake(tempCenter.x + 300, tempCenter.y);
  } completion:^(BOOL finished) {
    [weakSelf.topViewController.view addGestureRecognizer:weakSelf.tapToCloseRecognizer];
  }];
}

#pragma tapToClose
- (void)tapToClose
{
  NSLog(@"close up that hamburger menu");
  
  //removes the tapToCloseRecognizer from the view
  [self.topViewController.view removeGestureRecognizer:self.tapToCloseRecognizer];
  
  //doesn't always need to be called - however it is safe to implement and avoid retain cycles
  __weak BurgerContainerController *weakSelf = self;
  
  [UIView animateWithDuration:ANIMATIONDURATION animations:^{
    weakSelf.topViewController.view.center = weakSelf.view.center;
  } completion:^(BOOL finished) {
    self.burgerButton.userInteractionEnabled = true;
  }];
}

#pragma slideTopVC
- (void)slideTopVC:(id)sender
{
 //cast sender to pan
  UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
  [[[pan view ] layer] removeAllAnimations]; //removes all other animations from the views layer
  
  //need a copy of the gestures location and velocity
  CGPoint velocity        = [pan velocityInView:[sender view]];// velocity
  CGPoint translatedPoint = [pan translationInView:self.view]; // location
  
  //refrence to topViewController.view to clean up the code a bit
  UIView *myView = self.topViewController.view;
  
  //variable to clean up code in animateWithDuration
  CGSize mySize = myView.frame.size;
  
  //check if pan's state has changed ie userinteraction is detected
  if ([pan state] == UIGestureRecognizerStateChanged)
  {
    if (velocity.x > 0 || myView.frame.origin.x > 0)
    {
      myView.center = CGPointMake(myView.center.x + translatedPoint.x, myView.center.y);
      [pan setTranslation:CGPointMake(0,0) inView:self.view];
    }
  }
  
  //if userinteraction ends
  if ([(UIPanGestureRecognizer *)sender state] == UIGestureRecognizerStateEnded)
  {
    if (myView.frame.origin.x > self.view.frame.size.width / 4)  // opens the menu
    {
      self.burgerButton.userInteractionEnabled = false;
      
      [myView addGestureRecognizer:self.tapToCloseRecognizer];
      
      [UIView animateWithDuration:ANIMATIONDURATION animations:^{
        myView.frame = CGRectMake(mySize.width * 0.75, myView.frame.origin.y, mySize.width, mySize.height);
      }];
    }
  } else {
    //closes the menu
    self.burgerButton.userInteractionEnabled = true;
    [UIView animateWithDuration:ANIMATIONDURATION animations:^{
      myView.frame = CGRectMake(0, myView.frame.origin.y, mySize.width, mySize.height);
    }];
  }
}

#pragma menuOptionSelected
- (void)menuOptionSelected:(NSInteger)optionRow
{
  NSLog(@"%ld",(long)optionRow);
}


@end





