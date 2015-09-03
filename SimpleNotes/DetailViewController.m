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
@property (strong, nonatomic)UIImage *chosenImage;
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
    NSLog(@"%@",self.detailDescriptionLabel.text);
}

- (void)menuItemAdditions
{
  //  UIMenuItem *menuAddition = [[UIMenuItem alloc] initWithTitle:@"Bullets" action:@selector(addBullets:)];
    UIMenuItem *bold = [[UIMenuItem alloc] initWithTitle:@"image" action:@selector(imageSelector:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects: bold, nil]];
}

- (void)imageSelector:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    [self.detailDescriptionLabel addSubview:self.chosenImage];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.chosenImage = chosenImage;
    UIBezierPath *exclusionPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.chosenImage.size.width, self.chosenImage.size.height)];
    
    self.detailDescriptionLabel.textContainer.exclusionPaths  = @[exclusionPath];
    
    [self.detailDescriptionLabel addSubview:chosenImage ];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)addBullets:(id)sender
{

    NSArray * items = @[self.detailDescriptionLabel.text];
    NSMutableString * bulletList = [NSMutableString stringWithCapacity:items.count*30];
    for (NSString * s in items)
    {
        [bulletList appendFormat:@"\u2022 %@\n", s];
    }
//    self.detailDescriptionLabel.text = bulletList;
//    NSString *string = self.detailDescriptionLabel.text;
//    if (self.detailDescriptionLabel.text) {
//        NSString *bullet = @"\u2022 " ;
//        self.detailDescriptionLabel.text = [bullet stringByAppendingString:self.detailDescriptionLabel.text];
//    }
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
