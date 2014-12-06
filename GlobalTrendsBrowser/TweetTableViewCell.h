//
//  TweetTableViewCell.h
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 06/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *screenNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *profilePicImageView;
@property (nonatomic, strong) IBOutlet UILabel *tweetLabel;

@property (nonatomic, strong) NSString *imageUrl;

@end
