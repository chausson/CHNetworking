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
@interface ViewController ()

@end

@implementation ViewController{
    ASImageIdAPI *api;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    api = [[ASImageIdAPI alloc]init];
    


    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)action:(UIButton *)sender {
    [api startWithSuccessBlock:^(__kindof CHBaseRequest *request) {
        ASImageIdAPI *imageid = (ASImageIdAPI *)request;
        NSLog(@"imageid.imageIds=%@",[imageid getImageIds]);
    } failureBlock:^(__kindof CHBaseRequest *request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
