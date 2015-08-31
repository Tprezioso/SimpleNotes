//
//  DetailViewController.h
//  SimpleNotes
//
//  Created by Thomas Prezioso on 8/31/15.
//  Copyright (c) 2015 Thomas Prezioso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Note *detailItem;
@property (weak, nonatomic) IBOutlet UITextView *detailDescriptionLabel;

@end

