//
//  FMModulesViewController.m
//  CocoaSpriteTool
//
//  Created by Fernando Mazzon on 2/13/14.
//  Copyright (c) 2014 Fernando Mazzon. All rights reserved.
//

#import "FMModulesViewController.h"
#import "FMSprite.h"
#import "FMModulesRenderView.h"

@interface FMModulesViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSArrayController *arrayController;
@property (weak) IBOutlet FMModulesRenderView *modulesRenderView;

@end

@implementation FMModulesViewController

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return [self.sprite.modules count];
}

- (id)tableView:(NSTableView *)tv objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	return [self.sprite.modules objectAtIndex:row];
}


- (void)setSprite:(FMSprite *)sprite
{
    _sprite = sprite;
    self.modulesRenderView.image = self.sprite.image;
    self.modulesRenderView.modules = self.sprite.modules;
    [self.modulesRenderView setNeedsDisplay:YES];
}

@end
