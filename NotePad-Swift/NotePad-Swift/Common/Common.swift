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

class Common: NSObject {
    
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
    
}
/*
所有 tag

tag ＝ 0 1 2 3 4 tabBarItem
tag ＝ 101 写评论内容的 UITextView






*/