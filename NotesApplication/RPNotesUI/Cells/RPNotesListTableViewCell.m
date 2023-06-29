//
//  RPNotesListTableViewCell.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPNotesListTableViewCell.h"
#import "RPNote.h"
#import "RPCustomization.h"
@import PureLayout;

@interface RPNotesListTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *labelNoteShortDescription;

@end

@implementation RPNotesListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.labelNoteShortDescription autoPinEdge:ALEdgeLeading
                                         toEdge:ALEdgeLeading
                                         ofView:self.contentView
                                     withOffset:RPCustomization.sharedInstance.notesGeometry.cellInsetLeft.floatValue];
    [self.labelNoteShortDescription autoPinEdge:ALEdgeTop
                                         toEdge:ALEdgeTop
                                         ofView:self.contentView
                                     withOffset:RPCustomization.sharedInstance.notesGeometry.cellInsetTop.floatValue];
    [self.labelNoteShortDescription autoPinEdge:ALEdgeTrailing
                                         toEdge:ALEdgeTrailing
                                         ofView:self.contentView
                                     withOffset:-1 * RPCustomization.sharedInstance.notesGeometry.cellInsetRight.floatValue];
    [self.labelNoteShortDescription autoPinEdge:ALEdgeBottom
                                         toEdge:ALEdgeBottom
                                         ofView:self.contentView
                                     withOffset:-1 * RPCustomization.sharedInstance.notesGeometry.cellInsetBottom.floatValue];
    [super updateConstraints];
}

-(void)setupWithData:(id _Nullable)data {
    if ([data isKindOfClass:[RPNote class]]) {
        self.labelNoteShortDescription.text = ((RPNote*)data).title;
    }
}

@end
