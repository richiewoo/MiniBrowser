//
//  ControlPanelView.h
//  MiniBrowser
//
//  Created by Xinbo Wu on 7/10/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _NavigationDir
{
    Navigation_Back,
    Navigation_Forward
} eNavigationDir;

@protocol ControlPanelViewDelegate <NSObject>
@optional
- (void) navigation:(eNavigationDir)dir;
- (void) gotoAddress:(NSString *) address;
@end

#define CONTROL_PANEL_VIEW_HEIGHT 80
@interface ControlPanelView : UIView
@property (nonatomic, weak) id<ControlPanelViewDelegate> delegate;

- (void) setNavigationEnable:(eNavigationDir) dir enable:(BOOL) st;
- (void) setAdrress:(NSString *)address title:(NSString *)title;
- (void) resignFirstResponder;
@end
