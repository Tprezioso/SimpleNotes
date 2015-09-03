//
//  DetailViewController.m
//  SimpleNotes
//
//  Created by Thomas Prezioso on 8/31/15.
//  Copyright (c) 2015 Thomas Prezioso. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (IBAction)shareButton:(id)sender;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Note *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = self.detailItem.note;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self.detailDescriptionLabel becomeFirstResponder];
    [self menuItemAdditions];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    Note *currentNote = [[Note getAllNotes] objectAtIndex:[Note getCurrentNoteIndex]];
    currentNote.note = self.detailDescriptionLabel.text;
    [[Note getAllNotes] setObject:currentNote atIndexedSubscript:[Note getCurrentNoteIndex]];
    if ([self.detailDescriptionLabel.text isEqualToString:@""]) {
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
    [self.detailDescriptionLabel toggleBoldface:self.detailDescriptionLabel.text];
}

- (void)italicText:(id)selector
{
    [self.detailDescriptionLabel toggleItalics:self.detailDescriptionLabel.text];
}

-(void)underlineText:(id)selector
{
    [self.detailDescriptionLabel toggleUnderline:self.detailDescriptionLabel.text];
}

- (IBAction)shareButton:(id)sender
{
    Note *currentNote = [[Note getAllNotes] objectAtIndex:[Note getCurrentNoteIndex]];
    currentNote.note = self.detailDescriptionLabel.text;
    NSArray *objectToShare = @[currentNote.note];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectToShare applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
