//
//  RatingView.m
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

#import "RatingView.h"

@implementation UIView (ViewGeometry)
- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

- (CGFloat) height
{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}
@end

@implementation RatingView
{
    UIView *_grayView;
    UIView *_yellowView;
}

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self _initRatingViews];
    }
    
    return self;
}

//唤醒Nib
- (void)awakeFromNib
{
    [self _initRatingViews];
}

//设置。。。
- (void)_initRatingViews{
    //响应单点触摸事件，默认为YES
    self.userInteractionEnabled = YES;
    
    self.backgroundColor = [UIColor clearColor];
    
    UIImage *grayImage = [UIImage imageNamed:@"gray"];
    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
    
    float imageWidth = grayImage.size.width;
    float imageHeight = grayImage.size.height;
    
    //1、添加灰色星星视图
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageWidth * 5, imageHeight)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    [self addSubview:_grayView];
    
    //2、添加金色星星视图
    _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageWidth * 5, imageHeight)];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    [self addSubview:_yellowView];
    
    // 放大的倍数
    float scale = self.height / imageHeight;
    
    CGAffineTransform newForm = CGAffineTransformMakeScale(scale, scale);
    _grayView.transform = newForm;
    _yellowView.transform = newForm;
    
    _grayView.origin = CGPointMake(0, 0);
    _yellowView.origin = CGPointMake(0, 0);
    
    self.width = _grayView.width;;
}

- (void)setRating:(float)rating{

    _rating = rating;
    
    //3、根据评分改变金色星星视图的宽度
    CGRect frame = CGRectMake(0, 0, _grayView.frame.size.width * _rating / 10, _grayView.frame.size.height);
    
    _yellowView.frame = frame;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //UITouch的常用属性
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
//    NSLog(@"%f", p.x/self.height * 2);
    [self setRating:p.x/self.height * 2]; //因为是 10分制 的只有 5 颗星星
    [self setNeedsDisplay];
}

@end
