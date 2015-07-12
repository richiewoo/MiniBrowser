//
//  ControlPanelView.m
//  MiniBrowser
//
//  Created by Xinbo Wu on 7/10/15.
//  Copyright (c) 2015 Xinbo Wu. All rights reserved.
//

#import "ControlPanelView.h"

#define CONTROL_HEIGHT      44
#define CONTROL_PADDING     5
#define BACK_BUTTON_WIDTH   44
#define FORWARD_BUTTON_WIDTH   44

@interface ControlPanelView () <UITextViewDelegate>

@property (nonatomic, strong) UIButton* backBtn;
@property (nonatomic, strong) UIButton* forwardBtn;
@property (nonatomic, strong) UIButton* addressBtn;
@property (nonatomic, strong) UITextView* addressInput;
@property (nonatomic, strong) NSString* address;

- (void)initUI;
- (void)buttonAction:(UIButton *) btn;

@end

@implementation ControlPanelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGRect _frame = self.frame;
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(CONTROL_PADDING, statusBarHeight, BACK_BUTTON_WIDTH, CONTROL_HEIGHT);
    [_backBtn setImage:[UIImage imageNamed:@"Navigation_Back_Normal.png"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"Navigation_Back_Highlighted.png"] forState:UIControlStateHighlighted];
    [_backBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
    _backBtn.enabled = NO;
    
    _frame = self.backBtn.frame;
    _forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _forwardBtn.frame = CGRectMake(_frame.origin.x + _frame.size.width + CONTROL_PADDING, statusBarHeight, BACK_BUTTON_WIDTH, CONTROL_HEIGHT);
    [_forwardBtn setImage:[UIImage imageNamed:@"Navigation_Forward_Normal.png"] forState:UIControlStateNormal];
    [_forwardBtn setImage:[UIImage imageNamed:@"Navigation_Forward_Highlighted.png"] forState:UIControlStateHighlighted];
    [_forwardBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_forwardBtn];
    _forwardBtn.enabled = NO;
    
    _frame = self.forwardBtn.frame;
    _addressInput = [[UITextView alloc]initWithFrame:CGRectMake(_frame.origin.x + _frame.size.width + CONTROL_PADDING, statusBarHeight, self.frame.size.width - (_frame.origin.x + _frame.size.width + CONTROL_PADDING +CONTROL_PADDING), CONTROL_HEIGHT)];
    [_addressInput setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    _addressInput.font = [UIFont systemFontOfSize:20];
    _addressInput.returnKeyType = UIReturnKeyGo;
    _addressInput.keyboardType = UIKeyboardTypeURL;
    _addressInput.text = @"http://";
    _addressInput.delegate = self;
    [self addSubview:_addressInput];
}

- (void) setNavigationEnable:(eNavigationDir) dir enable:(BOOL) st
{
    switch (dir) {
        case Navigation_Back:
        {
            self.backBtn.enabled = st;
        }
            break;
            
        case Navigation_Forward:
        {
            self.forwardBtn.enabled = st;
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - Button action
- (void)buttonAction:(UIButton *) btn
{
    if (btn == self.backBtn) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(navigation:)]) {
            [self.delegate navigation:Navigation_Back];
        }
    }
    if (btn == self.forwardBtn) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(navigation:)]) {
            [self.delegate navigation:Navigation_Forward];
        }
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == self.addressInput) {
        
        if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
            return YES;
        }
        [textView resignFirstResponder];
        
        self.address = textView.text;
        if (self.delegate && [self.delegate respondsToSelector:@selector(gotoAddress:)]) {
            [self.delegate gotoAddress:self.address];
        }
    }
    return NO;
}

@end
