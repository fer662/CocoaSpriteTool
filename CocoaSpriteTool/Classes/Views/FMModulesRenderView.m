//
//  FMModulesView.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "FMModulesRenderView.h"
#import "FMModule.h"
#import "NSCursor+FM.h"

NSString *const kSelectedModulesBindingKeyPath= @"selectedModules";
NSString *const kAllModulesBindingKeyPath= @"allModules";

typedef enum
{
    FMModulesRenderViewNone             = 0,
    FMModulesRenderViewPan              = 1 << 0,
    FMModulesRenderViewMovingModules    = 1 << 1,
    FMModulesRenderViewDraggingLeft     = 1 << 2,
    FMModulesRenderViewDraggingRight    = 1 << 3,
    FMModulesRenderViewDraggingTop      = 1 << 4,
    FMModulesRenderViewDraggingBottom   = 1 << 5,
    FMModulesRenderViewDraggingWhole    = 1 << 6,
    FMModulesRenderViewSelect           = 1 << 7,
} FMModulesRenderViewState;

@interface FMModulesRenderView ()

@property (nonatomic, assign) CGPoint lastMousePosition;
@property (nonatomic, assign) BOOL mouseDown;
@property (nonatomic, assign) FMModulesRenderViewState state;

@end

@implementation FMModulesRenderView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scale = 1;
        self.translate = CGPointMake(0, 0);
        self.drawAll = YES;
        
        int opts = (NSTrackingActiveAlways | NSTrackingInVisibleRect | NSTrackingMouseMoved);
        NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                            options:opts
                                                              owner:self
                                                           userInfo:nil];
        [self addTrackingArea:area];
    }
    return self;
}

- (void)awakeFromNib
{
    NSDictionary *options = @{ NSAllowsEditingMultipleValuesSelectionBindingOption:@YES };
    [self bind:kSelectedModulesBindingKeyPath
      toObject:self.arrayController
   withKeyPath:@"selectedObjects"
       options:options];
    [self bind:kAllModulesBindingKeyPath
      toObject:self.arrayController
   withKeyPath:@"arrangedObjects"
       options:options];
}

- (CGPoint)mousePositionInViewFromEvent:(NSEvent *)event
{
    CGPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
    point.y = lround(self.frame.size.height - point.y);
    point.x = lround(point.x);
    
    return point;
}

- (void)mouseDown:(NSEvent *)event
{
    CGPoint point = [self mousePositionInViewFromEvent:event];
    
    BOOL holdingControl = ((event.modifierFlags & NSControlKeyMask) != 0);
    
    self.state = [self moduleActionForPosition:point];
    
    self.lastMousePosition = point;
    self.mouseDown = YES;
    
    if (self.state == FMModulesRenderViewSelect) {
        for (FMModule *module in self.allModules) {
            if (CGRectContainsPoint(module.rectangle, point)) {
                if (![self.arrayController.selectedObjects containsObject:module]) {
                    [self.arrayController setSelectedObjects:@[module]];
                }
            }
        }
    }
    
    [self setNeedsDisplay:YES];
}

- (void)updateCursor
{
    FMModulesRenderViewState action = [self moduleActionForPosition:self.lastMousePosition];
    if (action == FMModulesRenderViewDraggingWhole) {
        [[NSCursor closedHandCursor] set];
    }
    else if ((action & FMModulesRenderViewDraggingLeft) != 0) {
        if ((action & FMModulesRenderViewDraggingTop) != 0) {
            [[NSCursor resizeNWSE] set];
        }
        else if ((action & FMModulesRenderViewDraggingBottom) != 0) {
            [[NSCursor resizeNESW] set];
        }
        else {
            [[NSCursor resizeLeftRightCursor] set];
        }
    }
    else if ((action & FMModulesRenderViewDraggingRight) != 0) {
        if ((action & FMModulesRenderViewDraggingTop) != 0) {
            [[NSCursor resizeNESW] set];
        }
        else if ((action & FMModulesRenderViewDraggingBottom) != 0) {
            [[NSCursor resizeNWSE] set];
        }
        else {
            [[NSCursor resizeLeftRightCursor] set];
        }
    }
    else if ((action & (FMModulesRenderViewDraggingTop | FMModulesRenderViewDraggingBottom)) != 0) {
        [[NSCursor resizeUpDownCursor] set];
    }
    else if ((action & FMModulesRenderViewPan) != 0) {
        [[NSCursor arrowCursor] set];
    }
    else {
        [[NSCursor arrowCursor] set];
    }
}

- (FMModule *)currentModule
{
    if ([self.selectedModules count] == 1) {
        return [self.selectedModules lastObject];
    }
    else {
        return nil;
    }
}

- (void)mouseDragged:(NSEvent *)event
{
    CGPoint position = [self mousePositionInViewFromEvent:event];
    CGPoint delta = CGPointMake(position.x - self.lastMousePosition.x, position.y - self.lastMousePosition.y);
    self.lastMousePosition = position;
    
    FMModule *currentModule = [self currentModule];
    
    if (currentModule) {
        if (self.mouseDown) {
            if ((self.state & FMModulesRenderViewDraggingWhole) != 0) {
                [currentModule offsetBy:delta];
            }
            
            if ((self.state & FMModulesRenderViewDraggingTop) != 0) {
                currentModule.y += delta.y;
                currentModule.height -= delta.y;
            }
            
            if ((self.state & FMModulesRenderViewDraggingLeft) != 0) {
                currentModule.x += delta.x;
                currentModule.width -= delta.x;
            }
            
            if ((self.state & FMModulesRenderViewDraggingRight) != 0) {
                currentModule.width += delta.x;
            }
            
            if ((self.state & FMModulesRenderViewDraggingBottom) != 0) {
                currentModule.height += delta.y;
            }
            
            if ((self.state & FMModulesRenderViewPan) != 0) {
                //self.translate.x += delta.x;
                //self.translate.y += delta.y;
            }

            [self setNeedsDisplay:YES];
        }
        else {
            //modulePictureBox_UpdateCursor();
        }
    }
}

- (void)mouseMoved:(NSEvent *)event
{
    self.lastMousePosition = [self mousePositionInViewFromEvent:event];
    [self updateCursor];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    self.mouseDown = NO;
    self.state = FMModulesRenderViewNone;
}

- (FMModulesRenderViewState)moduleActionForPosition:(CGPoint)position
{
    FMModulesRenderViewState ret = FMModulesRenderViewNone;
    
    if ([self.selectedModules count] == 1) {
        FMModule *selectedModule = [self.selectedModules lastObject];
        
        CGRect left = CGRectMake(selectedModule.x - 2, selectedModule.y - 2, 4, selectedModule.height + 4);
        CGRect right = CGRectMake(selectedModule.right - 2, selectedModule.y - 2, 4, selectedModule.height + 4);
        CGRect bottom = CGRectMake(selectedModule.x - 2, selectedModule.bottom - 2, selectedModule.width + 4, 4);
        CGRect top = CGRectMake(selectedModule.x - 2, selectedModule.y - 2, selectedModule.width + 4, 4);
        
        CGRect moduleRect = selectedModule.rectangle;
        
        ret = FMModulesRenderViewNone;
        
        if (CGRectContainsPoint(left, position))
        {
            ret = FMModulesRenderViewDraggingLeft;
        }
        if (CGRectContainsPoint(right, position))
        {
            ret |= FMModulesRenderViewDraggingRight;
        }
        if (CGRectContainsPoint(top, position))
        {
            ret |= FMModulesRenderViewDraggingTop;
        }
        if (CGRectContainsPoint(bottom, position))
        {
            ret |= FMModulesRenderViewDraggingBottom;
        }
        if (CGRectContainsPoint(moduleRect, position) && ret == FMModulesRenderViewNone)
        {
            ret = FMModulesRenderViewDraggingWhole;
        }
    }
    
    if (ret == FMModulesRenderViewNone)
    {
        for (FMModule *module in self.allModules) {
            if (CGRectContainsPoint(module.rectangle, position)) {
                if (![self.arrayController.selectedObjects containsObject:module]) {
                    return FMModulesRenderViewSelect;
                }
            }
        }
        
        ret = FMModulesRenderViewPan;
    }
    return ret;
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef content = [[NSGraphicsContext currentContext] graphicsPort];
    
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height);
    CGContextConcatCTM(content, flipVertical);
    
    [[NSColor blackColor] setFill];
    CGContextFillRect(content, dirtyRect);
    
    CGContextTranslateCTM(content, self.translate.x, self.translate.y);
    CGContextScaleCTM(content, self.scale, self.scale);
    
    if (self.image) {
        NSRect proposedRect = NSMakeRect(0, 0, self.image.size.width, self.image.size.height);
        CGImageRef imageRef = [self.image CGImageForProposedRect:&proposedRect
                                                         context:[NSGraphicsContext currentContext] hints:nil];
        CGContextDrawImage(content, CGRectMake(0, 0, self.image.size.width, self.image.size.height), imageRef);
    }
    
    if (self.drawAll) {
        NSMutableArray *unselectedModules = [self.allModules mutableCopy];
        [unselectedModules removeObjectsInArray:self.selectedModules];
        
        [[[NSColor redColor] colorWithAlphaComponent:0.5] setStroke];
        for (FMModule *module in unselectedModules) {
            [self drawModule:module inContext:content];
        }
    }
    [[NSColor blueColor] setStroke];

    for (FMModule *module in self.selectedModules) {
        [self drawModule:module inContext:content];
    }
}

- (void)drawModule:(FMModule *)module inContext:(CGContextRef)context
{
    //CGFloat dashLengths[] = { 2, 2 };
    //CGContextSetLineDash( context, 0, dashLengths, sizeof( dashLengths ) / sizeof( float ) );
    //CGContextSetLineWidth(context, 1);
    
    CGContextMoveToPoint(context, module.x, module.y);
    CGContextAddLineToPoint(context, module.x, module.y + module.height);
    CGContextAddLineToPoint(context, module.x + module.width, module.y + module.height);
    CGContextAddLineToPoint(context, module.x + module.width, module.y);
    CGContextClosePath(context);
    
    CGContextStrokePath(context);
}

@end
