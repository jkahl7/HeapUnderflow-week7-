//
//  Constants.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/17/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "Constants.h"

@implementation Constants
// constants for building the OAuth URL - TODO: is this too deconstructed??
NSString *const URL         = @"https://stackexchange.com/oauth/dialog?";
NSString *const CLIENTID    = @"client_id=4307";
NSString *const OAUTHSCOPE  =  @"&scope=no_expiry";
NSString *const REDIRECTURI = @"&redirect_uri=https://stackexchange.com/oauth/login_success";

// constants for building fetch url's
NSString *const FETCHURL = @"https://api.stackexchange.com/2.2/";
NSString *const SEARCH   = @"search?order=desc&sort=activity&site=stackoverflow&intitle=";
NSString *const KEY      = @"&key=uVvOtWqLKqWyHIi3r9xt0A((";
NSString *const USER     = @"me?order=desc&sort=name&site=stackoverflow&intitle=";
NSString *const ACCESS   = @"&access_token=";

NSInteger const BURGERLOC     = 5;
NSInteger const BURGERSIZE    = 50;
float const ANIMATIONDURATION = 0.3;

@end
