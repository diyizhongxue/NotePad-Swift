//
//  GorgetPassWordController.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/6.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class GorgetPassWordController: UIViewController {

    var passWordTextField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        
        creatViews()
    }
    func creatViews(){
        
        self.passWordTextField = UITextField(frame: CGRect(x: 10, y: 10, width: kScreenWidth - 20, height: 40))
        self.passWordTextField?.placeholder = "邮箱／电话号码"
        self.passWordTextField?.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(self.passWordTextField!)
        
        let btn = UIButton(frame: CGRect(x: 10, y: 60, width: kScreenWidth - 20, height: 40))
        btn.setTitle("确定", forState: .Normal)
        btn.backgroundColor = UIColor.greenColor()
        btn.addTarget(self, action: "forgetPassWord:", forControlEvents: .TouchUpInside)
        self.view?.addSubview(btn)
        
    }
    
    func forgetPassWord(btn:UIButton){
        
//        AVUser.requestPasswordResetForEmailInBackground(self.passWordTextField?.text) { (succeeded:Bool, error:NSError!) -> Void in
//            
//            if succeeded {
//                print("发送成功")
//                
//            } else {
//                
//            }
//        }
        AVUser.requestPasswordResetWithPhoneNumber(self.passWordTextField?.text) { (succeeded:Bool, error:NSError!) -> Void in
            
            if succeeded {
                print("发送成功")
                self.navigationController?.pushViewController(PassWordChangeController(), animated: true)
            } else {
                
            }
            
        }
        
        
        
        
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
