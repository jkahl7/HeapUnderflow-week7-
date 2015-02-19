//
//  MenuDelegate.h
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/18/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuDelegate <NSObject>

- (void)menuOptionSelected:(NSInteger)selectedRow;

@end
