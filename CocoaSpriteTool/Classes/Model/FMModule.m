//
//  FMModule.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "FMModule.h"
#import "NSString+FM.h"
#import "FMSprite.h"

static const NSInteger kDefaultModuleWidth = 50;
static const NSInteger kDefaultModuleHeight = 50;

@interface FMModule ()

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) FMSprite *sprite;

@end

@implementation FMModule

- (id)initWithX:(NSInteger)x
              y:(NSInteger)y
          width:(NSInteger)width
         height:(NSInteger)height
         sprite:(FMSprite *)sprite
           uuid:(NSString *)uuid
{
    if (self = [super init]) {
        self.x = x;
        self.y = y;
        self.width = width;
        self.height = height;
        self.sprite = sprite;
        self.uuid = uuid;
    }
    return self;
}

+ (FMModule *)moduleInSprite:(FMSprite *)sprite
{
    FMModule *module = [[FMModule alloc] initWithX:0
                                                 y:0
                                             width:kDefaultModuleWidth
                                            height:kDefaultModuleHeight
                                            sprite:sprite
                                              uuid:[NSString uuid]];
    return module;
}

- (CGRect)rectangle
{
    return CGRectMake(self.x, self.y, self.width, self.height);
}

- (NSInteger)right
{
    return self.x + self.width;
}

- (NSInteger)bottom
{
    return self.y + self.height;
}

- (void)offsetBy:(CGPoint)delta
{
    self.x += delta.x;
    self.y += delta.y;
}

- (void)setX:(NSInteger)x
{
    [[self.sprite.undoManager prepareWithInvocationTarget:self] setX:_x];
    if (![self.sprite.undoManager isUndoing]){
        [self.sprite.undoManager setActionName:@"Move Module"];
    }
    _x = x;
}

- (void)setY:(NSInteger)y
{
    [[self.sprite.undoManager prepareWithInvocationTarget:self] setY:_y];
    if (![self.sprite.undoManager isUndoing]){
        [self.sprite.undoManager setActionName:@"Move Module"];
    }
    _y = y;
}

- (void)setWidth:(NSInteger)width
{
    [(FMModule *)[self.sprite.undoManager prepareWithInvocationTarget:self] setWidth:_width];
    if (![self.sprite.undoManager isUndoing]){
        [self.sprite.undoManager setActionName:@"Move Module"];
    }
    _width = width;
}

- (void)setHeight:(NSInteger)height
{
    [(FMModule *)[self.sprite.undoManager prepareWithInvocationTarget:self] setHeight:_height];
    if (![self.sprite.undoManager isUndoing]){
        [self.sprite.undoManager setActionName:@"Move Module"];
    }
    _height = height;
}

@end
