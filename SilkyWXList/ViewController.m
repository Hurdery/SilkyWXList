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
    
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxBtn.frame = CGRectMake(self.view.centerX - 50, self.view.centerY - 50, 100, 100);
    [wxBtn setBackgroundImage:[UIImage imageNamed:@"wx"] forState:0];
    [self.view addSubview:wxBtn];
    [wxBtn
     addTarget:self action:@selector(wxClick) forControlEvents:1<<6];
    
}

-(void)wxClick {
    
    dgWXListViewController *wvc = [dgWXListViewController new];
    wvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:wvc animated:YES completion:nil];
   
}

@end
