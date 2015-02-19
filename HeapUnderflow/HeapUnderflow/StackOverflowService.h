//
//  StackOverflowService.h
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/17/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackOverflowService : NSObject

+ (id)sharedService;

- (void)fetchQuestionsWithSearchTerm:(NSString *)searchTerm
                   completionHandler:(void (^)(NSArray *results, NSString *errorString))completionHandler;

- (void)fetchUserProfile:(void (^)(NSArray *results, NSString *errorString))completionHandler;

- (void)fetchUserAvatar:(NSString *)imageURL withCompletionHandler:(void (^) (UIImage *image))completionHandler;

@end
