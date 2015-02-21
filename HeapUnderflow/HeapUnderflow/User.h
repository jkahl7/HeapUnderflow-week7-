//
//  User.h
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/18/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *userName;

//- (User *)initWithJsonData:(NSData *)jsonData;

+ (User *)userProfileData:(NSData *)jsonData;

@end
