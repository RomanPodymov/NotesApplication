//
//  RPUtilities.m
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

#import "RPUtilities.h"
#import "RPLocalizationMaster.h"
@import BlocksKit;
@import SVProgressHUD;

@implementation RPListItemParams

-(instancetype)initWithTitle:(NSString*)title handler:(ListItemHandler)handler {
    self = [super init];
    if (self) {
        _title = title;
        _handler = handler;
    }
    return self;
}

@end

@implementation RPLoaderIndicator

+(void)show {
    [SVProgressHUD show];
}

+(void)hide {
    [SVProgressHUD dismiss];
}

@end

@implementation NSObject (RPUtilities)

-(void)observeLocaleChanges {
    if ([self conformsToProtocol:@protocol(RPLocalizable)]) {
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(onLocaleChangedNotification:)
                                                   name:NOTIFICATION_LANGUAGE_CHANGED
                                                 object:nil];
    }
}

-(void)onLocaleChangedNotification:(NSNotification*)notification {
    if ([self conformsToProtocol:@protocol(RPLocalizable)]) {
        LOCALE_ID* nextLocaleID = notification.userInfo[NOTIFICATION_KEY_CURRENT_LOCALE];
        if (nextLocaleID != nil) {
            [((NSObject<RPLocalizable>*)self) onLocaleChanged:nextLocaleID];
        }
    }
}

@end

@implementation NSArray (RPUtilities)

-(BOOL)isEmpty {
    return self.count == 0;
}

@end

@implementation UIImage (RPUtilities)

+(UIImage* _Nullable)imageFromColor:(UIColor* _Nonnull)color withRect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    return [UIImage imageFromColor:color withRect:CGRectMake(0, 0, 1.0, 1.0)];
}

@end

@implementation UIViewController (RPUtilities)

-(void)showMessageWithTitle:(NSString* _Nonnull)title
                messageText:(NSString* _Nonnull)messageText
                    handler:(MessageHandler)handler {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:messageText
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:
        [UIAlertAction actionWithTitle:[RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BTN_OK]
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
        handler();
    }]];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

-(void)showItemsList:(NSArray<RPListItemParams*>*)itemsList {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    [itemsList bk_each:^(RPListItemParams* obj) {
        [alertController addAction:[UIAlertAction actionWithTitle:obj.title
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
            obj.handler();
        }]];
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:[RPLocalizationMaster.sharedInstance translate:TRANSLATION_KEY_BTN_CANCEL]
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) { }]];
    [self presentViewController:alertController animated:YES completion:^{

    }];
}

@end
