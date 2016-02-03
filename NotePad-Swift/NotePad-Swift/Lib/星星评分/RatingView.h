//
//  RatingView.h
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewFrameGeometry)
@property CGPoint origin;;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@end

@interface RatingView : UIView

@property (assign, nonatomic)float rating;

@end
