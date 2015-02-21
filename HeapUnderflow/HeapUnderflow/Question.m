//
//  Question.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/17/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "Question.h"

@implementation Question

// "display_name" / "profile_image" / title

+ (NSArray *)questionsFromJSON:(NSData *)jsonData
{
  NSError *error;
  NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:0
                                                                   error:&error];
  if (!error)
  {
    //NSLog(@"%@",jsonDictionary);
    NSMutableArray *tempResults = [[NSMutableArray alloc] init];
    NSArray *jsonArray = jsonDictionary[@"items"];
    //now I have an array of dictionaries - loop through and check for the keys I want
    for (NSDictionary *item in jsonArray)
    {
      Question *userQuestion = [[Question alloc] init];
      NSDictionary *owner = item[@"owner"];
      userQuestion.userName = owner[@"display_name"];
      userQuestion.imageURL = owner[@"profile_image"];
      userQuestion.questionText = item[@"title"];
      userQuestion.answerURL = item[@"link"];
      
      //NSLog(item[@"answer_count"] ? @"YES" : @"NO");
      if (item[@"is_answered"] != 0)
      {
        userQuestion.answered = YES;
      } else {
        userQuestion.answered = NO;
      }
      
      [tempResults addObject:userQuestion];
    }
    NSArray *results = [[NSArray alloc] initWithArray:tempResults];
    return results;
  } else {
    NSLog(@"error encountered= %@",error);
  }
  //return type is NSArray not NSMutableArray
  return @[@"error"];
}

@end
