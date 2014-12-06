//
//  TwitsViewController.m
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 05/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import "TweetsViewController.h"
#import "Helpers.h"

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isBusy = YES;
    
    [APP.twitter getSearchTweetsWithQuery:self.hashtag
                                  geocode:nil
                                     lang:nil
                                   locale:nil
                               resultType:nil
                                    count:nil
                                    until:nil
                                  sinceID:nil
                                    maxID:nil
                          includeEntities:nil
                                 callback:nil
                             successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
                                
                                 self.isBusy = NO;
                                 
                                 KYTableSection *section = [self addSection:@"TweetTableViewCell"];
                                 [section mapData:@"text" to:@"tweetLabel.text"];
                                 [section mapData:@"user.name" to:@"nameLabel.text"];
                                 [section mapData:@"user.screen_name" to:@"screenNameLabel.text"];
                                 [section mapData:@"user.profile_image_url" to:@"imageUrl"];
                                 
                                 for (NSDictionary *data in statuses) {
                                     [section addRow:[[KYTableRow alloc] initWithData:data]];
                                 }
                                 
                                 [self.tableView reloadData];

                             } errorBlock:^(NSError *error) {
                                 
                                 self.isBusy = NO;
                                 ALERT(@"Error loading twits", error.localizedDescription);
                                 
                             }];
    
}

@end
