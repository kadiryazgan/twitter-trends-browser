//
//  KYTableSection.m
//  TwitSearch
//
//  Created by Kadir Yazgan on 05/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import "KYTableSection.h"

@implementation KYTableSection

- (id)init {
    if ((self = [super init])) {
        rows = [[NSMutableArray alloc] init];
        mapping = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)mapData:(NSString *)dataPath to:(NSString *)cellPath {
    [mapping setValue:cellPath forKey:dataPath];
}

- (void)bindRowAt:(long)rowIndex toCell:(UITableViewCell *)cell {
    KYTableRow *row = [self rowAt:rowIndex];
    for (NSString *key in mapping.allKeys) {
        id value = [row.data valueForKeyPath:key];
        NSString *cellPath = [mapping valueForKey:key];
        if (value == [NSNull null]) {
            value = @"";
        }
        [cell setValue:value forKeyPath:cellPath];
    }
}

- (void)addRow:(KYTableRow *)row {
    [rows addObject:row];
}

- (void)removeRow:(KYTableRow *)row {
    [rows removeObject:row];
}

- (void)removeRowAt:(long)index {
    [rows removeObjectAtIndex:index];
}

- (long)numRows {
    return rows.count;
}

- (KYTableRow*)rowAt:(long)index {
    return [rows objectAtIndex:index];
}

- (void)empty {
    [rows removeAllObjects];
}

- (void)setData:(NSArray *)data {
    for (id d in data) {
        [self addRow:[[KYTableRow alloc] initWithData:d]];
    }
}
@end
