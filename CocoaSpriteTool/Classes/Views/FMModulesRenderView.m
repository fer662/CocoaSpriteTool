//
//  FMModulesView.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "FMModulesRenderView.h"
#import "FMModule.h"

@implementation FMModulesRenderView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scale = 1;
        self.translate = CGPointMake(0, 0);
    }
    return self;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    [self.delegate modulesRenderViewMouseDown:self];
}

- (void)mouseMoved:(NSEvent *)theEvent
{
    [self.delegate modulesRenderViewMouseMoved:self];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    [self.delegate modulesRenderViewMouseUp:self];
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef content = [[NSGraphicsContext currentContext] graphicsPort];
    
    CGContextTranslateCTM(content, self.translate.x, self.translate.y);
    CGContextScaleCTM(content, self.scale, self.scale);
    
    if (self.image) {
        NSRect proposedRect = NSMakeRect(0, 0, self.image.size.width, self.image.size.height);
        CGImageRef imageRef = [self.image CGImageForProposedRect:&proposedRect
                                                         context:[NSGraphicsContext currentContext] hints:nil];
        CGContextDrawImage(content, CGRectMake(0, 0, self.image.size.width, self.image.size.height), imageRef);
    }
    
    for (FMModule *module in self.modules) {
        NSBezierPath *bezierPath = [NSBezierPath bezierPathWithRect:NSMakeRect(module.x, module.y, module.width, module.height)];
        CGContextDrawPath((__bridge CGContextRef)(bezierPath), kCGPathStroke);
    }
}


@end
