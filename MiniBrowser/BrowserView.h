//
//  BrowserView.h
//  MiniBrowser
//
//  Created by Xinbo Wu on 7/11/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ControlPanelView.h"

@interface BrowserView : UIView

@property (nonatomic, strong) ControlPanelView* panelView;
@property (nonatomic, strong) UIProgressView* progressView;
@property (nonatomic, strong) WKWebView* webView;

@end
