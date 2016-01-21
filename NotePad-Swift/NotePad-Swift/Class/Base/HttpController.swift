//
//  HttpController.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/4.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*
网络请求
代理协议
try!

针对AFNETWorking 更新Xcode7.0后网络请求出现如下error
Error Domain=NSURLErrorDomain Code=-1022
在工程的 info.plist 文件中添加  网络请求－1022错误.png


*/





import UIKit

protocol HttpProtocolDelegate{

    func didReceiveResults(results:NSDictionary)
}

class HttpController: NSObject{
    
    var delegate : HttpProtocolDelegate?

    func onSearch(url:String){
    
        let url = NSURL(string:url)
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in

            let jsonDic:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            self.delegate?.didReceiveResults(jsonDic)
        }
    }
}
