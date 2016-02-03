//
//  Push_BookTitleController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/3.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*

block 用法

*/
typealias Push_TitleCallBack = (title:String)->Void

import UIKit

class Push_BookTitleController: UIViewController {
    
    var TitleField:UITextField?
    var callBack:Push_TitleCallBack?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        Common.addLeftBtn(self, btnTitle: "关闭")
        Common.addRightBtn(self, btnTitle: "确定")
        
        TitleField = UITextField(frame: CGRect(x: 10, y: 70, width: kScreenWidth - 20, height: 30))
        TitleField?.borderStyle = .RoundedRect
        TitleField?.placeholder = "书评标题"
        TitleField?.font = UIFont(name: MY_FONT, size: 18)
        self.view.addSubview(TitleField!)
        
        self.TitleField?.becomeFirstResponder()
    }
    
    func colse(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    func sure(){
        self.callBack!(title: (self.TitleField?.text)!)
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
