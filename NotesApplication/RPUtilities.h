//
//  RPUtilities.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef void(^MessageHandler)(void);
typedef void(^ListItemHandler)(void);

@interface RPListItemParams: NSObject

-(instancetype _Nullable)initWithTitle:(NSString* _Nonnull)title handler:(ListItemHandler _Nonnull)handler;
@property (nonnull, nonatomic, strong, readonly) NSString* title;
@property (nonnull, nonatomic, strong, readonly) ListItemHandler handler;

@end

@interface RPLoaderIndicator: NSObject

+(void)show;
+(void)hide;

@end

@interface NSObject (RPUtilities)

-(void)observeLocaleChanges;

@end

@interface NSArray (RPUtilities)

-(BOOL)isEmpty;

@end

@interface UIImage (RPUtilities)

+(UIImage* _Nullable)imageFromColor:(UIColor* _Nonnull)color withRect:(CGRect)rect;
+(UIImage* _Nullable)imageFromColor:(UIColor* _Nonnull)color;

@end

@interface UIViewController (RPUtilities)

-(void)showMessageWithTitle:(NSString* _Nonnull)title
                messageText:(NSString* _Nonnull)messageText
                    handler:(MessageHandler _Nonnull)handler;
-(void)showItemsList:(NSArray<RPListItemParams*>* _Nonnull)itemsList;

@end

#define SHARED_CLASS() \
    + (instancetype _Nullable)sharedInstance;

#define MAKE_SHARED(CLASS_NAME) \
    + (instancetype)sharedInstance { \
        static CLASS_NAME *sharedInstanceValue = nil; \
        @synchronized(self) { \
            if (sharedInstanceValue == nil) \
                sharedInstanceValue = [[self alloc] init]; \
        } \
        return sharedInstanceValue; \
    }
