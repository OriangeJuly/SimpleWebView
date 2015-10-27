//
//  ViewController.m
//  UIWebView1014
//
//  Created by apple on 15/10/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate,UIImagePickerControllerDelegate>
{
    UIWebView *_webView;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:
                self.view.bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cn.bing.com/?setlang=zh-CN"]];
    
    [_webView loadRequest:request];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setTitle:@"Back" forState:UIControlStateNormal];
    backBut.frame = CGRectMake(30, 20, 80, 40);
    backBut.backgroundColor = [UIColor blackColor];
    [backBut addTarget:self action:@selector(GobackBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBut];
    
    
}

- (void)GobackBut:(id)sender
{
    [_webView goBack];
    NSLog(@"Want back");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark// UIwebViewDelegate method

                #pragma mark// 1.Get the webview's Action(重要：获取网页的动作)
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"request:%@",request);
   // return YES;

    if ([request.URL.absoluteString isEqualToString:@"http://cn.bing.com/?setlang=zh-CN/login"])
    {
        [self PickerImage];
        return NO;
    }
    else if ([[request.URL absoluteString] isEqualToString:@"die://openPicker"])
    {
        [self PickerImage];
        return NO;
    }
    else
    {
        return YES;
    }
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"Start Load");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Finshed Load");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"error:%@",error);
}



- (void)PickerImage
{
    UIImagePickerController *picker = [[UIImagePickerController
                                        alloc] init]; //1. 设置数据源
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //2. 设置媒体类型
    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    //3. 通过代理获取数据
    picker.delegate = self;
    //4. 显⽰页面
    [self presentViewController:picker animated:YES
                     completion:nil];
}


    #pragma mark //UIImagePickerControllerDelegate method

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    NSLog(@"editingInfo:%@",editingInfo);
    NSString *path = [NSHomeDirectory()
                      stringByAppendingPathComponent:@"Documents/test.jpg"];
    //
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
    [data writeToFile:@"/Users/apple/Desktop/test.jpg" atomically:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
#if 0
    //   load locate View
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request1];

    //   JS   (set logo)
    NSString *js = [NSString stringWithFormat:@"document.getElementById('image').src='%@'",path];
    [_webView stringByEvaluatingJavaScriptFromString:js];
#endif
#if 0
    //   JS       send data(show  photo)
    NSString *js = [NSString stringWithFormat:@"test('%@')",[NSURL fileURLWithPath:path].absoluteString];
    [_webView stringByEvaluatingJavaScriptFromString:js];
#endif
    
#pragma mark// Use Base64 Change The phonto
    NSString *js;
    NSString *imgBase64str = [data base64EncodedStringWithOptions:0];
    
    js = [NSString stringWithFormat:@"document.getElementsByClassName('logo')[0].childNodes[0].src='data:image/png;base64,%@'",imgBase64str];
    
    [_webView stringByEvaluatingJavaScriptFromString:js];
    
    
}

@end
