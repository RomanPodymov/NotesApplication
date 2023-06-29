//
//  AFNetworkingConnector.h
//  NotesApplication
//
//  Created by Roman Podymov on 29/06/2023.
//  Copyright © 2023 NotesApplication. All rights reserved.
//

@import Foundation;
#import "RPNetworkConnectable.h"

@interface AFNetworkingConnector: NSObject

@end

@interface AFNetworkingConnector (RPNetworkConnectableStuff) <RPNetworkConnectable>

@end
