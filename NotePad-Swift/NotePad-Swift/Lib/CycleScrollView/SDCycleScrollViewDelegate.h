//
//  SDCycleScrollViewDelegate.h
//  NotePad-Swift
//
//  Created by Silver on 15/12/31.
//  Copyright © 2015年 Silver. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SDCycleScrollView;

@protocol SDCycleScrollViewDelegate <NSObject>

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;


@end
