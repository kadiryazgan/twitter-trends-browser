//
//  TopicsViewController.m
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 05/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import "TrendsViewController.h"
#import "TweetsViewController.h"
#import "Helpers.h"

@implementation TrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isBusy = YES;
    
    [APP.twitter getTrendsForWOEID:self.woeid excludeHashtags:nil successBlock:^(NSDate *asOf, NSDate *createdAt, NSArray *locations, NSArray *trends) {
        self.isBusy = NO;
        
        KYTableSection *section = [self addSection:nil];
        [section mapData:@"name" to:@"textLabel.text"];
        
        for (NSDictionary *data in trends) {
            [section addRow:[[KYTableRow alloc] initWithData:data]];
        }

        [self.tableView reloadData];

    } errorBlock:^(NSError *error) {
        self.isBusy = NO;
        ALERT(@"Error getting trends", error.localizedDescription);
    }];
}

- (void)rowSelected:(KYTableRow *)row {

    TweetsViewController *tvc = [[TweetsViewController alloc] init];
    tvc.hashtag = [row.data objectForKey:@"name"];
    tvc.title = [row.data objectForKey:@"name"];
    [self.navigationController pushViewController:tvc animated:YES];

}

@end
