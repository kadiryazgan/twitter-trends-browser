//
//  KYTableSection.h
//  TwitSearch
//
//  Created by Kadir Yazgan on 05/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KYTableRow.h"
#import <UIKit/UIKit.h>

@interface KYTableSection : NSObject
{
    NSMutableArray *rows;
    NSMutableDictionary *mapping;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *footer;
@property (nonatomic, strong) NSString *rowType;
@property (nonatomic, readonly) long numRows;

- (void)addRow:(KYTableRow*)row;
- (void)removeRow:(KYTableRow*)row;
- (void)removeRowAt:(long)index;
- (KYTableRow*)rowAt:(long)index;
- (void)empty;

- (void)mapData:(NSString*)dataPath to:(NSString*)cellPath;

- (void)bindRowAt:(long)rowIndex toCell:(UITableViewCell*)cell;

- (void)setData:(NSArray*)data;

@end
