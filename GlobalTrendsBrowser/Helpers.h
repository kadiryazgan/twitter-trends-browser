//
//  helpers.h
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 05/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#include "AppDelegate.h"

#ifndef TwitSearch_helpers_h
#define TwitSearch_helpers_h

#define APP ((AppDelegate*)([UIApplication sharedApplication].delegate))

#define ALERT(title,msg) ([[[UIAlertView alloc] initWithTitle:(title)\
                                                      message:(msg)\
                                                     delegate:nil\
                                            cancelButtonTitle:@"OK"\
                                            otherButtonTitles:nil] show])

#endif
