//
//  LogInController.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/6.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*
UITextField

*/


import UIKit

class LogInController: UIViewController {
    
    var nameTextField:UITextField?
    var passWordTextField:UITextField?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .None
        
        creatViews()
    }
    func creatViews(){
        

        self.nameTextField = UITextField(frame: CGRect(x: 10, y: 10, width: kScreenWidth - 20, height: 40))
        self.nameTextField?.placeholder = "用户名"
        self.nameTextField?.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(self.nameTextField!)
        
        self.passWordTextField = UITextField(frame: CGRect(x: 10, y: 60, width: kScreenWidth - 20, height: 40))
        self.passWordTextField?.placeholder = "密码"
        self.passWordTextField?.secureTextEntry = true
        self.passWordTextField?.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(self.passWordTextField!)
        
        
        let btn = UIButton(frame: CGRect(x: 10, y: 110, width: kScreenWidth - 20, height: 40))
        btn.setTitle("登录", forState: .Normal)
        btn.backgroundColor = UIColor.greenColor()
        btn.addTarget(self, action: "logIn:", forControlEvents: .TouchUpInside)
        self.view?.addSubview(btn)
        
        
        Common.addNavRightBtn(self, btnTitle: "注册")
    }
    func makeSure(){
        self.navigationController?.pushViewController(RegisterController(), animated: true)
        
    }
    
    func logIn(btn:UIButton){
        AVUser.logInWithUsernameInBackground(self.nameTextField?.text, password: self.passWordTextField?.text) { (user:AVUser!, error:NSError!) -> Void in
            if user != nil{
                print("登录成功")
                
                self.navigationController?.popViewControllerAnimated(true)

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
