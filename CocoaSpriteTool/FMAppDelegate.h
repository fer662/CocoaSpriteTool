//
//  FMAppDelegate.h
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FMAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)undo:(id)sender;
- (IBAction)redo:(id)sender;

@end
