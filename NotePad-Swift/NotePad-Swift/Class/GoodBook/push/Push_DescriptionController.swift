//
//  Push_DescriptionController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/4.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

typealias Push_DescriptionControllerBlock=(description:String)->Void

class Push_DescriptionController: UIViewController {
    
    var textView : UITextView?
    var callBack:Push_DescriptionControllerBlock?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        Common.addLeftBtn(self, btnTitle: "关闭")
        Common.addRightBtn(self, btnTitle: "确定")
    
        self.textView = UITextView(frame: CGRectMake(8,58,kScreenWidth-16 ,kScreenHeight - 58 - 8))
        self.view.addSubview(self.textView!)
        self.textView?.font = UIFont(name: MY_FONT, size: 17)
        self.view.tintColor = UIColor.grayColor()
        self.textView?.becomeFirstResponder()
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidShow:"), name:UIKeyboardDidShowNotification, object: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func colse(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    func sure(){
        self.callBack!(description:(self.textView?.text)!)
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    /// 监听键盘弹出
    func keyboardDidShow(notification: NSNotification) {
        
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        let rect = value.CGRectValue
        self.textView?.contentInset = UIEdgeInsetsMake(0, 0, rect.size.height, 0)
    }
    
    /// 监听键盘收回
    func keyboardWillHide(notification: NSNotification) {
        
        self.textView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)

    }

}
