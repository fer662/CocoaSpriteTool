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

@interface FMModulesViewController () <NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSArrayController *arrayController;
@property (weak) IBOutlet FMModulesRenderView *modulesRenderView;

@end

@implementation FMModulesViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView
{
    [super loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingDidEnd:)
                                                 name:NSControlTextDidEndEditingNotification object:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewSelectionDidChange:) name:NSTableViewSelectionDidChangeNotification
                                               object:self.tableView];
}

- (void)setSprite:(FMSprite *)sprite
{
    _sprite = sprite;
    self.modulesRenderView.image = self.sprite.image;
    self.modulesRenderView.modules = self.sprite.modules;
    [self.modulesRenderView setNeedsDisplay:YES];
}

- (void)editingDidEnd:(NSNotification *)notification
{
    [self.modulesRenderView setNeedsDisplay:YES];
}

#pragma - NSTableViewDelegate

- (BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor
{
    return YES;
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor
{
    return YES;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    [self.modulesRenderView setNeedsDisplay:YES];
}

#pragma -

@end
