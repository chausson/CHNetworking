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
#import "HHTShiperExperienceApi.h"
@interface ViewController ()

@end

@implementation ViewController{
    ASImageIdAPI *image;
    SDLoginAPI *login;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [[CHNetworkConfig sharedInstance] setAllowPrintLog:YES];

    image = [[ASImageIdAPI alloc]init];
    login = [[SDLoginAPI alloc]initWithAccount:@"18116342840" password:@"111111"];


    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)image:(UIButton *)sender {
    [image startWithSuccessBlock:^(__kindof ASImageIdAPI *request) {
        
    } failureBlock:^(__kindof ASImageIdAPI *request) {
        
    }];
}
- (IBAction)action:(UIButton *)sender {
    [[CHNetworkConfig sharedInstance] setBaseUrl:@"http://shipping.sudaotech.com/platform"];
    HHTShiperExperienceApi *api = [[HHTShiperExperienceApi alloc]init];
    api.crewId = @"1";
    [api startWithSuccessBlock:^(__kindof HHTShiperExperienceApi *request) {
        [request getItems];
    } failureBlock:^(__kindof HHTShiperExperienceApi *request) {
        
    }];

}
- (IBAction)login:(UIButton *)sender {
    [[CHNetworkConfig sharedInstance] setBaseUrl:@"http://app4tv.sudaotech.com/platform"];
    [login startWithSuccessBlock:^(__kindof SDLoginAPI *request) {
        NSLog(@"token =%@",request.token);
    } failureBlock:^(__kindof SDLoginAPI *request) {

    }];
}
- (void)dealloc{
    
}

@end
