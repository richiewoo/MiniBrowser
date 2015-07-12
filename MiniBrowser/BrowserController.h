//
//  BrowserController.h
//  MiniBrowser
//
//  Created by Xinbo Wu on 7/10/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

typedef void (^UpdateProgressBlock) (float progress);
typedef void (^CanNavigateBlock) (NSString* navigateDir, BOOL canNav);

@interface BrowserController : NSObject 

- (instancetype) initWithWebview:(WKWebView*)webview;
- (void) loadWebAddress:(NSString *)address;

- (void) goForwordPage;
- (void) gobackwordPage;

- (void) setUpdateProgressBlock:(UpdateProgressBlock) block;
- (void) setCanNavigateBlock: (CanNavigateBlock) block;

@end
