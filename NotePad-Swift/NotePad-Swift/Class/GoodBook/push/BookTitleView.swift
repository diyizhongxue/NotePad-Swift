//
//  BookTitleView.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*
swift 中定义 oc 协议
swift 协议必须实现
oc 协议 可以选择实现 optional

*/

import UIKit
@objc protocol BookCoverDelegate{

    optional func bookCoverClick()
}

class BookTitleView: UIView {

    var bookCover:UIButton?
    var bookName:UITextField?
    var bookEditor:UITextField?
    
    var delegate:BookCoverDelegate?

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        bookCover = UIButton(frame: CGRect(x: 20, y: 10, width: 80, height: 110))
        bookCover?.backgroundColor = UIColor.redColor()
        bookCover?.addTarget(self, action: "bookCoverAction", forControlEvents: .TouchUpInside)
        self.addSubview(bookCover!)
        
        bookName = UITextField(frame: CGRect(x: 110, y: 20, width: kScreenWidth - 120, height: 30))
        bookName?.placeholder = "书名"
        bookName?.font = UIFont(name: MY_FONT, size: 20)
        self.addSubview(bookName!)
        
        bookEditor = UITextField(frame: CGRect(x: 110, y: 70, width: kScreenWidth - 120, height: 30))
        bookEditor?.placeholder = "作者"
        bookEditor?.font = UIFont(name: MY_FONT, size: 20)
        self.addSubview(bookEditor!)

        let line =  UIView(frame: CGRect(x: 0, y: 29, width: kScreenWidth - 120, height: 1))
        line.backgroundColor = UIColor.blackColor()
        
        let line1 =  UIView(frame: CGRect(x: 0, y: 29, width: kScreenWidth - 120, height: 1))
        line1.backgroundColor = UIColor.blackColor()

        bookName?.addSubview(line)
        bookEditor?.addSubview(line1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bookCoverAction(){
        delegate?.bookCoverClick!()
    }

}
