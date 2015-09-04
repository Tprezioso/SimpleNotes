//
//  DetailViewController.m
//  SimpleNotes
//
//  Created by Thomas Prezioso on 8/31/15.
//  Copyright (c) 2015 Thomas Prezioso. All rights reserved.
//

#import "DetailViewController.h"
#import <CoreText/CoreText.h>

@interface DetailViewController ()

- (IBAction)shareButton:(id)sender;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Note *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        self.detailTextView.text = self.detailItem.note;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    [self.detailTextView becomeFirstResponder];
    [self menuItemAdditions];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    Note *currentNote = [[Note getAllNotes] objectAtIndex:[Note getCurrentNoteIndex]];
    currentNote.note = self.detailTextView.text;
    [[Note getAllNotes] setObject:currentNote atIndexedSubscript:[Note getCurrentNoteIndex]];
    
    if ([self.detailTextView.text isEqualToString:@""]) {
        [[Note getAllNotes]removeObjectAtIndex:[Note getCurrentNoteIndex]];
    }
    [Note saveNotes];
    [[Note getTable] reloadData];
}

- (void)menuItemAdditions
{
    UIMenuItem *menuBold = [[UIMenuItem alloc] initWithTitle:@"Bold" action:@selector(boldText:)];
    UIMenuItem *menuItalic = [[UIMenuItem alloc] initWithTitle:@"Italic" action:@selector(italicText:)];
    UIMenuItem *menuUnderline = [[UIMenuItem alloc] initWithTitle:@"Underline" action:@selector(underlineText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:menuBold, menuItalic, menuUnderline, nil]];
}

- (void)boldText:(id)selector
{
    [self.detailTextView toggleBoldface:self.detailTextView.text];
}

- (void)italicText:(id)selector
{
    [self.detailTextView toggleItalics:self.detailTextView.text];
}

- (void)underlineText:(id)selector
{
    [self.detailTextView toggleUnderline:self.detailTextView.text];
}

- (IBAction)shareButton:(id)sender
{
    Note *currentNote = [[Note getAllNotes] objectAtIndex:[Note getCurrentNoteIndex]];
    currentNote.note = self.detailTextView.text;
    NSArray *objectToShare = @[currentNote.note];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectToShare applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
