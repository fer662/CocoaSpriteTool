//
//  FMModule.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "FMModule.h"
#import "NSString+FM.h"

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

@end
