//
//  StackOverflowService.h
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/17/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowService : NSObject

+ (id)sharedService;

- (void)fetchQuestionsWithSearchTerm:(NSString *)searchTerm
                   completionHandler:(void (^)(NSArray *results, NSString *errorString))completionHandler;

- (UIImage)fetchUserAvatar:(NSString *)imageURL;

@end
