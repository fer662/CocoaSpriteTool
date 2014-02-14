//
//  FMAppDelegate.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "FMAppDelegate.h"
#import "FMModulesViewController.h"
#import "FMFramesViewController.h"
#import "FMAnimationsViewController.h"

#import "FMSprite.h"

@interface FMAppDelegate () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak, nonatomic) IBOutlet NSTabView *tabView;

@property (strong, nonatomic) IBOutlet FMModulesViewController *modulesViewController;
@property (strong, nonatomic) IBOutlet FMFramesViewController *framesViewController;
@property (strong, nonatomic) IBOutlet FMAnimationsViewController *animations;

@property (strong, nonatomic) FMSprite *sprite;

@end

@implementation FMAppDelegate

- (void)setSprite:(FMSprite *)sprite
{
    _sprite = sprite;
    self.modulesViewController.sprite = sprite;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.sprite = [[FMSprite alloc] init];
    [self.sprite addModule];
    [self.sprite addModule];
    
    [[self.tabView tabViewItemAtIndex:0] setView:self.modulesViewController.view];
    [[self.tabView tabViewItemAtIndex:1] setView:self.framesViewController.view];
    [[self.tabView tabViewItemAtIndex:1] setView:self.animations.view];
}

@end
