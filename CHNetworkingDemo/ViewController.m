//
//  ViewController.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/10.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "ViewController.h"
#import "ASImageIdAPI.h"
#import "CHNetworkConfig.h"
#import "SDLoginAPI.h"
@interface ViewController ()

@end

@implementation ViewController{
    ASImageIdAPI *image;
    SDLoginAPI *login;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [[CHNetworkConfig sharedInstance] setAllowPrintLog:YES];
    [[CHNetworkConfig sharedInstance] setBaseUrl:@"http://app4tv.sudaotech.com/platform"];
    image = [[ASImageIdAPI alloc]init];
    login = [[SDLoginAPI alloc]initWithAccount:@"18116342840" password:@"111111"];


    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)action:(UIButton *)sender {
    [login startWithSuccessBlock:^(__kindof SDLoginAPI *request) {
        NSLog(@"token =%@",request.token);
    } failureBlock:^(__kindof SDLoginAPI *request) {
        
    }];
}

- (void)dealloc{
    
}

@end
