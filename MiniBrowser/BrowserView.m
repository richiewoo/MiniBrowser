//
//  BrowserView.m
//  MiniBrowser
//
//  Created by Xinbo Wu on 7/11/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import "BrowserView.h"
#import "BrowserController.h"

@interface BrowserView () 

- (void)initUI;

@end

@implementation BrowserView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    
    return self;
}

- (void)initUI
{
    CGRect _frame = self.frame;
    _panelView = [[ControlPanelView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, CONTROL_PANEL_VIEW_HEIGHT)];
    [_panelView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_panelView];
    
    _frame.origin.y = _panelView.frame.origin.y + _panelView.frame.size.height;
    _frame.size.height = _frame.size.height - _panelView.frame.size.height;
    _webView = [[WKWebView alloc] initWithFrame:_frame];
    [_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self addSubview:_webView];
    
    _frame.origin.y = _panelView.frame.origin.y + _panelView.frame.size.height +2;
    _progressView = [[UIProgressView alloc] initWithFrame:_frame];
    [_progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.progressTintColor = [UIColor grayColor];
    [self.progressView setTransform:CGAffineTransformMakeScale(1.0, 3.0)];
    [self addSubview:_progressView];
}

@end
