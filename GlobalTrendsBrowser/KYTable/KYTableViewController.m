//
//  KYTableViewController.m
//  TwitSearch
//
//  Created by Kadir Yazgan on 05/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import "KYTableViewController.h"
#import "RegionTableViewCell.h"
#define CELL_IDENTIFIER @"cell1"

@interface KYTableViewController ()

@end

@implementation KYTableViewController

- (id)init {
    if ((self = [super init])) {
        
        _sections = [[NSMutableArray alloc] init];
        aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aiv];
    }
    return self;
}

- (void)setIsBusy:(BOOL)isBusy {
    _isBusy = isBusy;
    if (_isBusy) {
        [aiv startAnimating];
    } else {
        [aiv stopAnimating];
    }
}

- (KYTableSection*)addSection:(id)rowTypeOrSection {

    KYTableSection *section;
    if ([rowTypeOrSection isKindOfClass:[KYTableSection class]]) {
        section = rowTypeOrSection;
    } else {
        section = [[KYTableSection alloc] init];
        section.rowType = rowTypeOrSection;
    }
    if (section.rowType) {
        [self.tableView registerNib:[UINib nibWithNibName:section.rowType bundle:nil] forCellReuseIdentifier:section.rowType];
    } else {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
    }
    [self.sections addObject:section];
    return section;

}

- (KYTableSection*)sectionAt:(long)index {
    return [self.sections objectAtIndex:index];
}

- (KYTableRow*)rowAt:(NSIndexPath*)indexPath {
    return [[self sectionAt:indexPath.section] rowAt:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self sectionAt:section].numRows;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self sectionAt:section].title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KYTableSection *section = [self sectionAt:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(section.rowType? section.rowType : CELL_IDENTIFIER) forIndexPath:indexPath];

    [section bindRowAt:indexPath.row toCell:cell];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self rowSelected:[self rowAt:indexPath]];
}

- (void)rowSelected:(KYTableRow *)row {
}

@end
