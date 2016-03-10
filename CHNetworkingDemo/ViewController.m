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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ASImageIdAPI *api = [[ASImageIdAPI alloc]init];
    
    [api startWithSuccessBlock:^(__kindof CHBaseRequest *request) {
        ASImageIdAPI *imageid = (ASImageIdAPI *)request;
        NSLog(@"imageid.imageIds=%@",[imageid getImageIds]);
    } failureBlock:^(__kindof CHBaseRequest *request) {
        
    }];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
