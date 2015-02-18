//
//  Question.h
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/17/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Question : NSObject

@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *questionText;

@property (strong, nonatomic) UIImage  *userAvatar;

+ (NSArray *)questionsFromJSON:(NSData *)jsonData;


@end
