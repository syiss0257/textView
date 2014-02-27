//
//  ViewController.h
//  textView
//
//  Created by ohtake shingo on 2014/02/27.
//  Copyright (c) 2014年 ohtake shingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    float originalHeight;
}
@property (strong, nonatomic) IBOutlet UIView *textBar;

@property (strong, nonatomic) IBOutlet UITextView *textView;
- (IBAction)textBtn:(id)sender;
@end
