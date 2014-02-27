//
//  ViewController.m
//  textView
//
//  Created by ohtake shingo on 2014/02/27.
//  Copyright (c) 2014年 ohtake shingo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    originalHeight = CGRectGetHeight(_textView.frame);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) moveTextViewForKeyboard:(NSNotification*)aNotification up: (BOOL) up
{
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    animationCurve = animationCurve<<16;//ios7からの変更
    
    
    CGRect newFrame = _textView.frame;

    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];

    if (up) {
        //newFrame.size.height = originalHeight - CGRectGetHeight(keyboardEndFrame);//NO bar
        newFrame.size.height = originalHeight - CGRectGetHeight(keyboardEndFrame)-CGRectGetHeight(_textBar.frame);
    } else{
        //newFrame.size.height += CGRectGetHeight(keyboardEndFrame)//NO bar
        newFrame.size.height += CGRectGetHeight(keyboardEndFrame)+CGRectGetHeight(_textBar.frame);
    }
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:animationCurve
                     animations:^{
                         _textView.frame = newFrame;
                         //bar exist
                         _textBar.frame = CGRectMake(0, _textView.frame.size.height, CGRectGetWidth(_textBar.frame), CGRectGetHeight(_textBar.frame));
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    [self moveTextViewForKeyboard:aNotification up:YES];
    
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    [self moveTextViewForKeyboard:aNotification up:NO];
}

- (IBAction)textBtn:(id)sender {
    [_textView resignFirstResponder];
}
@end
