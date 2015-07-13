//
//  BrowserController.m
//  MiniBrowser
//
//  Created by Xinbo Wu on 7/10/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import "BrowserController.h"

@interface BrowserController () <WKNavigationDelegate>

@property(nonatomic, strong) WKWebView* wbview;
@property(nonatomic, strong) NSString* address;
@property(nonatomic, copy)  UpdateProgressBlock updateProgressblk;
@property(nonatomic, copy)  CanNavigateBlock    canNavigateBlk;
@property(nonatomic, copy)  ReturnAddressAndTitleBlock updateAddressAndTitleBlk;

@end

@implementation BrowserController

#pragma mark - Initialization
- (instancetype)init
{
    return nil;
}

- (instancetype)initWithWebview:(WKWebView*)webview
{
    if (self = [super init]) {
        self.wbview = webview;
        [self initWebView];
    }
    return self;
}

- (void)initWebView
{
    self.wbview.navigationDelegate = self;
    [self.wbview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wbview addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wbview addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wbview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wbview addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:NULL];
}

#pragma mark - Navigates to the website
- (void)loadWebAddress:(NSString *)address
{
    if (!([address hasPrefix:@"http://"] || [address hasPrefix:@"https://"])) {
        self.address = [@"http://" stringByAppendingString:address];
    }
    else
    {
        self.address = address;
    }
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:[NSURL URLWithString:self.address]];
    [self.wbview loadRequest:urlReq];
}

- (void)goForwordPage
{
    [self.wbview goForward];
}

- (void)gobackwordPage
{
    [self.wbview goBack];
}

#pragma mark - Set the callback
- (void) setUpdateProgressBlock:(UpdateProgressBlock) block
{
    self.updateProgressblk = block;
}

- (void) setCanNavigateBlock: (CanNavigateBlock) block
{
    self.canNavigateBlk = block;
}

- (void) setReturnAddrTitleBlock: (ReturnAddressAndTitleBlock) block
{
    self.updateAddressAndTitleBlk = block;
}

#pragma mark - NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.wbview) {
        self.updateProgressblk(self.wbview.estimatedProgress);
    }else if ([keyPath isEqualToString:@"canGoBack"] && object == self.wbview) {
        self.canNavigateBlk(keyPath, self.wbview.canGoBack);
    }else if ([keyPath isEqualToString:@"canGoForward"] && object == self.wbview) {
        self.canNavigateBlk(keyPath, self.wbview.canGoForward);
    }else if (([keyPath isEqualToString:@"URL"]||[keyPath isEqualToString:@"title"]) && object == self.wbview) {
        self.updateAddressAndTitleBlk([self.wbview.URL absoluteString], self.wbview.title);
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    // Loading error display...
    
}

@end
