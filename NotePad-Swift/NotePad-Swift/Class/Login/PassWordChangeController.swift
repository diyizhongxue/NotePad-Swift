//
//  PassWordChangeController.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/6.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class PassWordChangeController: UIViewController {

    var nameTextField:UITextField?
    var passWordTextField:UITextField?
    var newPassWordTextField:UITextField?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        
        creatViews()
    }
    func creatViews(){
        
        self.passWordTextField = UITextField(frame: CGRect(x: 10, y: 10, width: kScreenWidth - 20, height: 40))
        self.passWordTextField?.placeholder = "旧密码"
        self.passWordTextField?.secureTextEntry = true
        self.passWordTextField?.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(self.passWordTextField!)
        
        self.newPassWordTextField = UITextField(frame: CGRect(x: 10, y: 60, width: kScreenWidth - 20, height: 40))
        self.newPassWordTextField?.placeholder = "新密码"
        self.newPassWordTextField?.secureTextEntry = true
        self.newPassWordTextField?.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(self.newPassWordTextField!)
        
        
        let btn = UIButton(frame: CGRect(x: 10, y: 110, width: kScreenWidth - 20, height: 40))
        btn.setTitle("确定", forState: .Normal)
        btn.backgroundColor = UIColor.greenColor()
        btn.addTarget(self, action: "passWordChange:", forControlEvents: .TouchUpInside)
        self.view?.addSubview(btn)
        
    }
    
    func passWordChange(btn:UIButton){
        AVUser.currentUser().updatePassword(self.passWordTextField?.text, newPassword: self.newPassWordTextField?.text) { (object, error:NSError!) -> Void in
            
            if object != nil{
            
                print("修改成功")

            }else{
                
                print(error)

            }
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
