//
//  RPNetworkDataProvider.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "RPDataProvider.h"

typedef NS_ENUM(NSUInteger, REQUEST_METHOD) {
    METHOD_GET,
    METHOD_POST,
    METHOD_DELETE,
    METHOD_PUT
};

@interface RPNetworkDataProvider: NSObject

@end

@interface RPNetworkDataProvider (RPDataProviderStuff) <RPDataProvider>

@end
