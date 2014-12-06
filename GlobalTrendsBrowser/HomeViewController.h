//
//  HomeViewController.h
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 05/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* aiv;
- (IBAction)connectTwitter:(id)sender;

@end
