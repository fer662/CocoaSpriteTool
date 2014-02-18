//
//  NSCursor+FM.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/18/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "NSCursor+FM.h"

@implementation NSCursor (FM)

+ (NSCursor *)resizeNESW
{
    NSString *cursorName = @"resizenortheastsouthwest";
    NSString *cursorPath = [@"/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/HIServices.framework/Versions/A/Resources/cursors" stringByAppendingPathComponent:cursorName];
    NSImage *image = [[NSImage alloc] initByReferencingFile:[cursorPath stringByAppendingPathComponent:@"cursor.pdf"]];
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[cursorPath stringByAppendingPathComponent:@"info.plist"]];
    NSCursor *cursor = [[NSCursor alloc] initWithImage:image hotSpot:NSMakePoint([[info valueForKey:@"hotx"] doubleValue], [[info valueForKey:@"hoty"] doubleValue])];
    return cursor;
}

+ (NSCursor *)resizeNWSE
{
    NSString *cursorName = @"resizenorthwestsoutheast";
    NSString *cursorPath = [@"/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/HIServices.framework/Versions/A/Resources/cursors" stringByAppendingPathComponent:cursorName];
    NSImage *image = [[NSImage alloc] initByReferencingFile:[cursorPath stringByAppendingPathComponent:@"cursor.pdf"]];
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[cursorPath stringByAppendingPathComponent:@"info.plist"]];
    NSCursor *cursor = [[NSCursor alloc] initWithImage:image hotSpot:NSMakePoint([[info valueForKey:@"hotx"] doubleValue], [[info valueForKey:@"hoty"] doubleValue])];
    return cursor;
}


@end
