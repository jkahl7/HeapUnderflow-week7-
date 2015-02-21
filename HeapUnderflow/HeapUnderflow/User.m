//
//  User.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/18/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "User.h"

@implementation User

/*- (User *)initWithJsonData:(NSData *)jsonData
{
  if (!jsonData)
  {
    NSLog(@"init fail - jsonData: %@", jsonData);
  } else {
    NSError *error;
    NSDictionary *serializedJSON = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    self.userName = serializedJSON[@"display_name"];
  }
}
*/

+ (User *)userProfileData:(NSData *)jsonData
{
  if (!jsonData)
  {
    NSLog(@"error with getting JSONobjectsWithData");
    return nil;
  } else {
    NSError *error;
    NSDictionary *userJsonData = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:0
                                                                   error:&error];
    User *user = [[User alloc]init];
    user.userName = userJsonData[@"display_name"];
    return user;
  }
}


@end
