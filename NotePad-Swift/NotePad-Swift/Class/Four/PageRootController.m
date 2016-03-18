//
//  PageRootController.m
//  NotePad-Swift
//
//  Created by 王立震 on 16/3/18.
//  Copyright © 2016年 Silver. All rights reserved.
//

#import "PageRootController.h"
#import "OtherViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface PageRootController ()

@end

@implementation PageRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"杨可囊";
}
- (instancetype)init{
    
    PageRootController *pageVC = nil;
    if (self = [super init]) {
        
        pageVC = [self p_defaultController];
        
        pageVC.menuHeight = 40.0; //页卡高度
        pageVC.menuViewStyle = WMMenuViewStyleLine; //页卡样式
        pageVC.menuItemWidth = kScreenWidth/4.0; //显示页卡宽度
        pageVC.titleSizeSelected = 17; //点击后 字体大小
        pageVC.titleSizeNormal = 15; //点击前字体大小
        pageVC.titleColorSelected = [UIColor redColor]; //点击后颜色
        pageVC.pageAnimatable = YES; //动画
        pageVC.postNotification = YES;
        pageVC.bounces = YES;//弹簧
    }
    return pageVC;
}

//添加控制器
- (PageRootController *)p_defaultController{
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:{
                vcClass = [OtherViewController class];
                title = @"第一页";
            }
                break;
            case 1:{
                vcClass = [OtherViewController class];
                title = @"第二页";
            }
                break;
            case 2:{
                vcClass = [OtherViewController class];
                title = @"第三页";
            }
                break;
            case 3:{
                vcClass = [OtherViewController class];
                title = @"第四页";
            }
                break;
            case 4:{
                vcClass = [OtherViewController class];
                title = @"第五页";
            }
                break;
            case 5:{
                vcClass = [OtherViewController class];
                title = @"第六页";
            }
                break;
            case 6:{
                vcClass = [OtherViewController class];
                title = @"第七页";
            }
                break;

            default:
                vcClass = [OtherViewController class];
                title = @"第八页";
                break;
        }
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
    PageRootController *pageVC = [[PageRootController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    return pageVC;
    
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
