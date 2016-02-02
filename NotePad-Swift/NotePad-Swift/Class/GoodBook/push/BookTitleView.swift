//
//  BookTitleView.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class BookTitleView: UIView {

    var bookCover:UIButton?
    var bookName:UITextField?
    var bookEditor:UITextField?

    override init(frame: CGRect) {
        super.init(frame:frame)
        bookCover = UIButton(frame: CGRect(x: 20, y: 20, width: 80, height: 110))
        bookCover?.backgroundColor = UIColor.redColor()
        self.addSubview(bookCover!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
