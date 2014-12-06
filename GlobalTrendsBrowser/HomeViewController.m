//
//  HomeViewController.m
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 05/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import "HomeViewController.h"
#import <STTwitter/STTwitterAPI.h>
#import "RegionsViewController.h"
#import "Helpers.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GlobalTrendsBrowser";
}

- (IBAction)connectTwitter:(id)sender {

    if (!APP.twitter) {
        APP.twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
    }
    
    if (APP.twitter.userName) {
        
        self.navigationItem.title = APP.twitter.userName;
        [self showRegionSelector];

    } else {
        
        [self.aiv startAnimating];
        
        [APP.twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
            [self.aiv stopAnimating];
            [self showRegionSelector];
            
        } errorBlock:^(NSError *error) {
            [self.aiv stopAnimating];
            ALERT(@"Error verifying credentials", error.localizedDescription);

        }];
        
    }
}


- (void)showRegionSelector {
    RegionsViewController *rvc = [[RegionsViewController alloc] init];
    rvc.title = APP.twitter.userName;
    [self.navigationController pushViewController:rvc animated:YES];
}

@end
