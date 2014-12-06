//
//  TweetTableViewCell.m
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 06/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import "TweetTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation TweetTableViewCell

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.profilePicImageView setImageWithURL:[NSURL URLWithString:imageUrl]];
}
@end
