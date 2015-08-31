//
//  Note.m
//  SimpleNotes
//
//  Created by Thomas Prezioso on 8/31/15.
//  Copyright (c) 2015 Thomas Prezioso. All rights reserved.
//

#import "Note.h"

#define kAllNotes @"allthenotes"
static NSInteger currentNoteIndex = -1;
static NSMutableArray *allNotes = nil;
static UITableView *tableView;

@implementation Note

- (instancetype)init
{
    self = [super init];
    if (self) {
        _note = @"";
        _date = [NSDate date].description;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _note = [coder decodeObjectForKey:@"note"];
        _date = [coder decodeObjectForKey:@"date"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.note forKey:@"note"];
    [aCoder encodeObject:self.date forKey:@"date"];
}

+ (UITableView *)getTable
{
    return tableView;
}

+ (void)setTable:(UITableView *)table
{
    tableView = table;
}

+ (void)saveNotes
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:allNotes];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAllNotes];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)loadNotes
{
    if (allNotes == nil) {
        allNotes = [NSMutableArray arrayWithArray:@[]];
    }
    NSData *rawData = [[NSUserDefaults standardUserDefaults] dataForKey:kAllNotes];
    if (rawData == nil) {
        return;
    }
    NSArray *allData = [NSKeyedUnarchiver unarchiveObjectWithData:rawData];
    allNotes = [NSMutableArray arrayWithArray:allData];
}

+ (NSInteger)getCurrentNoteIndex
{
    return currentNoteIndex;
}

+ (void)setCurrentNoteIndex:(NSInteger)index
{
    currentNoteIndex = index;
}

+ (NSMutableArray *)getAllNotes
{
    return allNotes;
}

@end
