//
//  ListOneController.m
//  NotePad-Swift
//
//  Created by 王立震 on 16/1/21.
//  Copyright © 2016年 Silver. All rights reserved.
//

#import "ListOneController.h"

@interface ListOneController ()

@end

@implementation ListOneController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self _initView];
}
- (void)_initView{

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
    label.text = @"Swift和OC是可以混用的！！别找借口";
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
