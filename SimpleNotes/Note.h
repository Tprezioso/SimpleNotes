//
//  Note.h
//  SimpleNotes
//
//  Created by Thomas Prezioso on 8/31/15.
//  Copyright (c) 2015 Thomas Prezioso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Note : NSObject <NSCoding>
{
    
}

@property NSString *note;
@property NSString *date;

+ (UITableView *)getTable;
+ (void)setTable:(UITableView *)table;
+ (void)saveNotes;
+ (void)loadNotes;
+ (NSInteger)getCurrentNoteIndex;
+ (void)setCurrentNoteIndex:(NSInteger)index;
+ (NSMutableArray *)getAllNotes;

@end
