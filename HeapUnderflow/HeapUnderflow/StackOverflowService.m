//
//  StackOverflowService.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/17/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "StackOverflowService.h"
#import "Constants.h"
#import "Question.h"
#import "User.h"

@implementation StackOverflowService

//class method that returns a signleton instance
+ (id)sharedService
{//static = scope is limited to the class it is in
  static StackOverflowService *stackoverflowSharedService;
  static dispatch_once_t dispatchToken;
  dispatch_once(&dispatchToken, ^{
    stackoverflowSharedService = [[StackOverflowService alloc] init];
  });
  return stackoverflowSharedService;
}

#pragma fetchQuestionsWithSearchTerm
- (void)fetchQuestionsWithSearchTerm:(NSString *)searchTerm
                   completionHandler:(void (^)(NSArray *results, NSString *errorString))completionHandler
{
  NSString *urlString = FETCHURL; // base url
  urlString = [urlString stringByAppendingString:SEARCH];
  urlString = [urlString stringByAppendingString:searchTerm];
 
  //check for token, if true append it to the url string
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults objectForKey:@"token"];
  if (token)
  {
    urlString = [urlString stringByAppendingString:ACCESS];
    urlString = [urlString stringByAppendingString:token];
    urlString = [urlString stringByAppendingString:KEY];
  }
  NSURL *url = [NSURL URLWithString:urlString];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod = @"GET";
  
  //every app has a nsurlShared session you can use
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
  {
    if (error)
    {
      completionHandler(nil, @"Unable to establish a connection");
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode = httpResponse.statusCode;
      
      switch (statusCode)
      {
        case 200 ... 299:
        {
          NSLog(@"%ld",statusCode);
          NSArray *results = [Question questionsFromJSON:data]; //loads our results into a question model object
          //now return to the main queue
          dispatch_async(dispatch_get_main_queue(), ^{
            if (results)
            {
              completionHandler(results,nil);
            } else {
              completionHandler(nil,@"ruh roh");
            }
          });
          break;
        }
        case 300 ... 599:
        {
          NSLog(@"%ld",statusCode);
          break;
        }
        default:
        {
          NSLog(@"default case reached");
        }
      }
    }
  }];
  [dataTask resume];
}

#pragma fetchUserProfile
- (void)fetchUserProfile:(void (^)(User *userInfo, NSString *errorString))completionHandler
{
  NSString *baseURL = URL;
  baseURL = [baseURL stringByAppendingString:USER];
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults objectForKey:@"token"];
 
  if (token)
  {
    baseURL = [baseURL stringByAppendingString:ACCESS];
    baseURL = [baseURL stringByAppendingString:token];
    baseURL = [baseURL stringByAppendingString:KEY];
  }

  NSURL *url = [NSURL URLWithString:baseURL];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod = @"GET";
  NSURLSession *session = [NSURLSession sharedSession];
  //Tasks are always part of a session; you create a task by calling one of the task creation methods on an NSURLSession object.
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
  {
    if (error)
    {
      NSLog(@"error in dataTask: %@",error);
      dispatch_async(dispatch_get_main_queue(), ^{
        completionHandler(nil, @"error in dataTask");
      });
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger taskResponse = httpResponse.statusCode;
      
      switch (taskResponse)
      {
        case 200 ... 299:
        {
          NSLog(@"%ld", (long)taskResponse);
          User *user = [User userProfileData:data];
          dispatch_async(dispatch_get_main_queue(), ^{
            if (user)
            {
              NSLog(@"user not nil: %@", user.userName);
              completionHandler(user, nil);

            } else {
              NSLog(@"problems: %@",user.userName);
              completionHandler(nil,@"issue with json results");
            }
          });
          break;
        }
        case 300 ... 599:
        {
          NSLog(@"%ld", (long)taskResponse);
          break;
        }
        default:
        {
          break;
        }
      }
    }
  }];
  [dataTask resume];
}

#pragma fetchUserAvatar
- (void)fetchUserAvatar:(NSString *)imageURL withCompletionHandler:(void (^) (UIImage *image))completionHandler
{
  dispatch_queue_t imageQueue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
  dispatch_async(imageQueue, ^{
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandler(image);
    });
  });
}



@end
