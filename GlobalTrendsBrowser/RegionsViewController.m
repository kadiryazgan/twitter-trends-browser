//
//  RegionsViewController.m
//  GlobalTrendsBrowser
//
//  Created by Kadir Yazgan on 05/12/14.
//  Copyright (c) 2014 Kadir Yazgan. All rights reserved.
//

#import "RegionsViewController.h"
#import "TrendsViewController.h"
#import <STTwitter/STTwitterAPI.h>
#import "Helpers.h"
#import "Country.h"
#import "City.h"

@interface RegionsViewController()<UISearchBarDelegate>
{
    UISearchBar *searchBar;
}
@end

@implementation RegionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.countryCode) {
        searchBar = [[UISearchBar alloc] init];
        searchBar.returnKeyType = UIReturnKeyDone;
        searchBar.delegate = self;
        self.navigationItem.titleView = searchBar;
    }
    
    if (![self fillTable]) {

        self.isBusy = YES;
        
        [APP.twitter getTrendsAvailableWithSuccessBlock:^(NSArray *locations) {
            
            self.isBusy = NO;
            [self persistLocations:locations];
            [self fillTable];
            
        } errorBlock:^(NSError *error) {
            
            self.isBusy = NO;
            ALERT(@"Error getting regions", error.localizedDescription);
            
        }];

    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)sb {
    [sb resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if (!searchText.length) {
    
        [self fillTable];

    } else {
        
        NSArray *items = [self loadEntities:@"City" predicate:[NSPredicate predicateWithFormat:@"name LIKE[c] %@", [NSString stringWithFormat:@"%@*", searchText]]];
        [self fillTable:items];

    }
}

- (BOOL)fillTable {
    
    NSArray *items = nil;
    if (self.countryCode) {
        items = [self loadEntities:@"City" predicate:[NSPredicate predicateWithFormat:@"countryCode=%@", self.countryCode]];
    } else {
        items = [self loadEntities:@"Country" predicate:nil];
    }
    if (!items) return NO;
    
    [self fillTable:items];
    return YES;

}

- (void)fillTable:(NSArray*)items {

    [self.sections removeAllObjects];

    KYTableSection *section;
    
    if (self.countryCode || searchBar.text.length) {
        section = [self addSection:@"RegionTableViewCell"];
        [section mapData:@"name" to:@"name.text"];
        [section mapData:@"countryCode" to:@"code.text"];
    } else {
        section = [self addSection:nil];
        [section mapData:@"name" to:@"textLabel.text"];
    }
    
    [section setData:items];
    [self.tableView reloadData];

}
    
- (void)rowSelected:(KYTableRow *)row {

    UIViewController *vc;
    
    if ([row.data isKindOfClass:[City class]]) {
        City *city = row.data;
        TrendsViewController *tvc = [[TrendsViewController alloc] init];
        tvc.woeid = [NSString stringWithFormat:@"%@", city.woeid];
        tvc.title = city.name;
        vc = tvc;
    } else {
        Country *country = row.data;
        RegionsViewController *rvc = [[RegionsViewController alloc] init];
        rvc.countryCode = country.code;
        rvc.title = country.name;
        vc = rvc;
    }

    [self.navigationController pushViewController:vc animated:YES];
}






- (void)persistLocations:(NSArray*)locations {
    
    NSMutableSet *countries = [[NSMutableSet alloc] init];
    
    for (id data in locations) {
        NSString *cc = [data objectForKey:@"countryCode"];
        NSString *country = [data objectForKey:@"country"];
        NSString *name = [data objectForKey:@"name"];
        NSNumber *woeid = [data objectForKey:@"woeid"];
        
        if (cc == (id)[NSNull null]) continue;
        
        if (![countries containsObject:cc]) {
            [countries addObject:cc];
            
            Country *c = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:APP.managedObjectContext];
            c.name = country;
            c.code = cc;
        }
        
        City *city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:APP.managedObjectContext];
        city.countryCode = cc;
        city.name = name;
        city.woeid = woeid;
    }
    
    NSError *error;
    if (![APP.managedObjectContext save:&error]) {
        ALERT(@"Error persisting data", error.localizedDescription);
    }
}

- (NSArray*)loadEntities:(NSString*)entityName predicate:(NSPredicate*)predicate {

    NSFetchRequest *fr = [[NSFetchRequest alloc] init];
    fr.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:APP.managedObjectContext];
    fr.predicate = predicate;
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSError *error;
    NSArray *ar = [APP.managedObjectContext executeFetchRequest:fr error:&error];
    if (error) {
        NSLog(@"error fetching %@: %@", entityName, error.localizedDescription);
        return nil;
    }
    
    if (!ar.count) return nil;
    
    return ar;
}

@end
