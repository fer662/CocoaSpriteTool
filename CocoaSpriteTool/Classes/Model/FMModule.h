//
//  FMModule.h
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMSprite;
@interface FMModule : NSObject

+ (FMModule *)moduleInSprite:(FMSprite *)sprite;

@property (nonatomic, strong, readonly) FMSprite *sprite;
@property (nonatomic, strong, readonly) NSString *uuid;

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) CGRect rectangle;
@property (nonatomic, assign, readonly) NSInteger right;
@property (nonatomic, assign, readonly) NSInteger bottom;

- (void)offsetBy:(CGPoint)delta;

@end
