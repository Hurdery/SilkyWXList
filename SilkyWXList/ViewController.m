//
//  ViewController.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/9.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "ViewController.h"
#import "dgWXListViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self presentViewController:[dgWXListViewController new] animated:YES completion:nil];
   
}

@end
