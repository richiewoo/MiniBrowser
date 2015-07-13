//
//  ViewController.m
//  MiniBrowser
//
//  Created by Xinbo Wu on 7/10/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import "ViewController.h"
#import "BrowserView.h"
#import "BrowserController.h"

@interface ViewController () <ControlPanelViewDelegate>

@property (nonatomic, strong) BrowserView* browserView;
@property (nonatomic, strong) BrowserController* browserCtl;

- (void)initBrowserController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _browserView = [[BrowserView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_browserView];
    self.browserView.panelView.delegate = self;
    [self initBrowserController];
    [self.browserCtl loadWebAddress:@"www.tango.me/"];
}

- (void)initBrowserController
{
    _browserCtl = [[BrowserController alloc] initWithWebview:_browserView.webView];
    __weak __typeof(self)weakSelf = self;
    [self.browserCtl setUpdateProgressBlock: ^(float prgress){
        [weakSelf.browserView.progressView setProgress:prgress animated:YES];
        if (prgress >= 1) {
            weakSelf.browserView.progressView.progress = 0;
        }
    }];
    [self.browserCtl setCanNavigateBlock: ^(NSString* navigateDir, BOOL canNav){
        if ([navigateDir isEqualToString:@"canGoBack"]){
            [weakSelf.browserView.panelView setNavigationEnable:Navigation_Back enable:canNav];
        }else if ([navigateDir isEqualToString:@"canGoForward"]){
            [weakSelf.browserView.panelView setNavigationEnable:Navigation_Forward enable:canNav];
        }
    }];
    [self.browserCtl setReturnAddrTitleBlock:^(NSString* address, NSString* title){
        [weakSelf.browserView.panelView setAdrress:address title:title];
    }];
}

#pragma mark - ControlPanelViewDelegate
- (void)navigation:(eNavigationDir)dir
{
    if (Navigation_Back == dir) {
        [self.browserCtl gobackwordPage];
    } else if (Navigation_Forward == dir) {
        [self.browserCtl goForwordPage];
    }
}

- (void)gotoAddress:(NSString *) address
{
    [self.browserCtl loadWebAddress:address];
}

@end
