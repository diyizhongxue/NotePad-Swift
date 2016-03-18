//
//  OtherViewController.m
//  两个tableView
//
//  Created by 王立震 on 16/3/16.
//  Copyright © 2016年 王立震. All rights reserved.
//

#import "OtherViewController.h"
#import "OneCell.h"
#import "TwoCell.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "WMPageController.h"

@interface OtherViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
    UITableView *tableView1;
    UITableView *tableView2;
    
    NSDictionary *dic;
    NSString *key;
    
}

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    dic = @{
            @"1":@[@"1", @"11", @"111", @"1111"],
            @"2":@[@"2", @"22", @"222"],
            @"3":@[@"3", @"33", @"333", @"3333", @"33333"],
            @"4":@[@"4", @"44"],
            @"5":@[@"5", @"55", @"555", @"5555", @"555555", @"555555", @"5555", @"55555"],
            @"6":@[@"6", @"66", @"666", @"6666"]
            };
    key = @"1";
    
    [self _initViews];
}

- (void)_initViews {
    
    tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, kScreenHeight)];
    tableView1.tag = 101;
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [self.view addSubview:tableView1];
    [tableView1 registerClass:[OneCell class] forCellReuseIdentifier:@"OneCell"];
    
    tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(80, 0, kScreenWidth - 80, kScreenHeight)];
    tableView2.tag = 102;
    tableView2.delegate = self;
    tableView2.dataSource = self;
    [self.view addSubview:tableView2];
    [tableView2 registerClass:[TwoCell class] forCellReuseIdentifier:@"TwoCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //预防两个tableView 的组数不一样
    if (tableView.tag == 101) {
        
        return 1;
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 101) {
        //随机的
        return [dic allKeys].count;
    }else{
        NSArray * array = [dic objectForKey:key];
        return array.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 101) {
        
        OneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell" forIndexPath:indexPath];
        cell.textLabel.text = [dic allKeys][indexPath.row];
        cell.backgroundColor = [UIColor grayColor];
        
        return cell;
        
    }else{
        
        TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoCell" forIndexPath:indexPath];
        NSArray * array = [dic objectForKey:key];
        cell.textLabel.text = array[indexPath.row];
        cell.backgroundColor = [UIColor purpleColor];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 101) {
        
        return 80;
    }else{
        return 40;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 101) {
        
        key = [dic allKeys][indexPath.row];
        [tableView2 reloadData];
        
    }else{
        
        WMPageController *pageController = [self p_defaultController];
        pageController.title = @"Line";
        [self.navigationController pushViewController:pageController animated:YES];
        //        NSLog(@"点击了第%li行", indexPath.row);
        
    }
}

- (WMPageController *)p_defaultController {
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [OtherViewController class];
                title = @"Greetings";
                break;
            case 1:
                vcClass = [OtherViewController class];
                title = @"Hit Me";
                break;
            default:
                vcClass = [OtherViewController class];
                title = @"Fluency";
                break;
        }
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.menuViewStyle = WMMenuViewStyleFooldHollow;
    pageVC.titleSizeSelected = 15;
    pageVC.pageAnimatable = YES;
    pageVC.menuItemWidth = 85;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    return pageVC;
}



@end
