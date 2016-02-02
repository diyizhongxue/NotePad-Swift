//
//  Common.swift
//  NotePad-Swift
//
//  Created by Silver on 15/12/27.
//  Copyright © 2015年 Silver. All rights reserved.
//

/*

String 转换为 float

*/

import UIKit

//尺寸
let kScreenWidth = UIScreen.mainScreen().bounds.width
let kScreenHeight = UIScreen.mainScreen().bounds.height
let kScale = UIScreen.mainScreen().bounds.width/320

//iOS版本
let isIOS7 = UIDevice.currentDevice().systemVersion._bridgeToObjectiveC().floatValue >= 7.0
let isIOS9 = UIDevice.currentDevice().systemVersion._bridgeToObjectiveC().floatValue >= 9.0

//工程 info
let infoDictionary:NSDictionary = NSBundle.mainBundle().infoDictionary!
// app名称
let app_Name = infoDictionary.objectForKey("CFBundleDisplayName")
// app版本
let app_Version = infoDictionary.objectForKey("CFBundleShortVersionString")
// app build版本
let app_build = infoDictionary.objectForKey("CFBundleVersion")


//特殊字体名字
let MY_FONT = "FZXingKai-S04"


class Common: NSObject {
    
    //计算字符串的size
    class func captureTextSizeWithText(text:NSString, textWidth width:CGFloat, font:String)->CGSize{
        
        let constraint = CGSize(width: width, height: 20000.0)
        let tdic = [font:NSFontAttributeName]
        let rect = text.boundingRectWithSize(constraint, options:NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: tdic, context: nil)
        
        var size:CGSize
        if rect.size.height < 15{
            size = CGSizeMake(kScreenWidth - 50, rect.size.height)
            
        }else if rect.size.height > 15 && rect.size.height < 30{
            size = CGSizeMake(kScreenWidth - 50, rect.size.height + 10)
            
        }else{
            size = CGSizeMake(kScreenWidth - 50, rect.size.height + 20)
        }
        
        if text.isEqualToString(""){
            size = CGSizeZero
        }
        return size
    }
    
    //调用此方法 一定要实现 close 方法
    static func addLeftBtn(target:UIViewController, btnTitle:String = "返回"){
    
        let btn = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 45))
        btn.contentHorizontalAlignment = .Left //按钮文字 居左
        btn.setTitle(btnTitle, forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont(name:MY_FONT, size: 20)
        btn.addTarget(target, action: "colse", forControlEvents: .TouchUpInside)
        target.view.addSubview(btn)
    }
    
    //调用此方法 一定要实现 sure 方法
    static func addRightBtn(target:UIViewController, btnTitle:String = "返回"){
        
        let btn = UIButton(frame: CGRect(x: kScreenWidth - 120, y: 20, width: 100, height: 45))
        btn.contentHorizontalAlignment = .Right //按钮文字 居左
        btn.setTitle(btnTitle, forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont(name:MY_FONT, size: 20)
        btn.addTarget(target, action: "sure", forControlEvents: .TouchUpInside)
        target.view.addSubview(btn)
    }
    
    //调用此方法 一定要实现 goBack 方法
    static func addNavLeftBtn(target:UIViewController, btnTitle:String = "返回"){
        
        let btn = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 45))
        btn.contentHorizontalAlignment = .Left //按钮文字 居左
        btn.setTitle(btnTitle, forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont(name:MY_FONT, size: 20)
        btn.addTarget(target, action: "goBack", forControlEvents: .TouchUpInside)
        
        let item = UIBarButtonItem(customView: btn)
        target.navigationItem.leftBarButtonItem = item
        
    }
    
    //调用此方法 一定要实现 makeSure 方法
    static func addNavRightBtn(target:UIViewController, btnTitle:String = "返回"){
        
        let btn = UIButton(frame: CGRect(x: kScreenWidth - 120, y: 20, width: 100, height: 45))
        btn.contentHorizontalAlignment = .Right //按钮文字 居左
        btn.setTitle(btnTitle, forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont(name:MY_FONT, size: 20)
        btn.addTarget(target, action: "makeSure", forControlEvents: .TouchUpInside)
        let item = UIBarButtonItem(customView: btn)
        target.navigationItem.rightBarButtonItem = item
    }
}
/*
所有 tag

tag ＝ 0 1 2 3 4 tabBarItem
tag ＝ 101 写评论内容的 UITextView



/usr/local/lib/node_modules
/usr/local/lib




*/