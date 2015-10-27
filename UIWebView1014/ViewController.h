//
//  ViewController.h
//  UIWebView1014
//
//  Created by apple on 15/10/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;


@end

