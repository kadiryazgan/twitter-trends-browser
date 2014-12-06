//
//  KYTableViewController.h
//  TwitSearch
//
//  Created by Kadir Yazgan on 05/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYTableSection.h"

@interface KYTableViewController : UITableViewController
{
    UIActivityIndicatorView *aiv;
}

@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, assign) BOOL isBusy;

- (KYTableSection*)addSection:(id)rowTypeOrSection;
- (KYTableSection*)sectionAt:(long)index;
- (void)rowSelected:(KYTableRow*)row;

@end
