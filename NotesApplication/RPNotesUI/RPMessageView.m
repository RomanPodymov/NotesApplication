//
//  RPMessageView.m
//  NotesApplication
//
//  Created by Roman Podymov on 04/07/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import PureLayout;
#import "RPMessageView.h"
#import "RPLocalizationMaster.h"

@interface RPMessageView ()

@property (nonatomic, nonnull, strong, readonly) UILabel* messageLabel;

@end

@implementation RPMessageView

@synthesize messageText = _messageText;
@synthesize messageTextTranslationKey = _messageTextTranslationKey;

-(void)commonInit {
    [super commonInit];
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_messageLabel];
    [self setupConstraints];
}

-(void)setupConstraints {
    [_messageLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

-(NSString* _Nullable)messageText {
    return _messageText;
}

-(void)setMessageText:(NSString* _Nullable)messageTextValue {
    _messageTextTranslationKey = nil;
    if (messageTextValue != nil) {
        _messageLabel.text = messageTextValue;
    }
    _messageText = messageTextValue;
}

-(NSString* _Nullable)messageTextTranslationKey {
    return _messageTextTranslationKey;
}

-(void)setMessageTextTranslationKey:(NSString* _Nullable)nextValue {
    _messageTextTranslationKey = nextValue;
    _messageText = [self setupTranslatedMessageText];
}

-(NSString*)setupTranslatedMessageText {
    if (_messageTextTranslationKey != nil) {
        _messageLabel.text = [RPLocalizationMaster.sharedInstance translate:_messageTextTranslationKey];
    }
    return _messageLabel.text;
}

#pragma mark Localizable

-(void)onLocaleChanged:(NSString *)nextLocale {
    [super onLocaleChanged:nextLocale];
    [self setupTranslatedMessageText];
}

#pragma mark Customizable

-(void)customize {
    [self setupStyles];
}

#pragma mark Styleable

-(void)setupStyles {
    self.backgroundColor = RPCustomization.sharedInstance.colors.colorMedium;
}

@end
