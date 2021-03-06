//
//  RegisterController.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/6.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    var segmentedControl:UISegmentedControl?
    
    var nameTextField:UITextField?
    var passWordTextField:UITextField?
    var phoneTextField:UITextField?
    var sendbtn:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .None
        
        creatViews()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidShow:"), name:UIKeyboardDidShowNotification, object: nil)
    }
    
    func creatViews(){
        
        self.segmentedControl = UISegmentedControl(items: ["邮箱注册","手机",])
        self.segmentedControl?.frame = CGRect(x: 10, y: 10, width: kScreenWidth - 20, height: 40)
        self.segmentedControl?.selectedSegmentIndex = 0
        self.segmentedControl?.momentary = false//设置在点击后是否恢复原样
        self.segmentedControl?.setTitle("手机注册", forSegmentAtIndex: 1)
//        self.segmentedControl?.insertSegmentWithTitle("邮箱注册", atIndex: 2, animated: false)
        //        self.chooseSegment?.setEnabled(false, forSegmentAtIndex: 0)//设置指定索引选项不可选
        self.segmentedControl?.addTarget(self, action: "segmentAction:", forControlEvents: UIControlEvents.ValueChanged)//看清枚举
        self.view.addSubview(self.segmentedControl!)
        
        
        self.nameTextField = UITextField(frame: CGRect(x: 10, y: 60, width: kScreenWidth - 20, height: 40))
        self.nameTextField?.placeholder = "用户名"
        self.nameTextField?.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(self.nameTextField!)
        
        self.passWordTextField = UITextField(frame: CGRect(x: 10, y: 110, width: kScreenWidth - 20, height: 40))
        self.passWordTextField?.placeholder = "密码"
        self.passWordTextField?.secureTextEntry = true
        self.passWordTextField?.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(self.passWordTextField!)
        
        self.phoneTextField = UITextField(frame: CGRect(x: 10, y: 160, width: kScreenWidth - 20, height: 40))
        self.phoneTextField?.placeholder = "邮箱(可不填)"
        self.phoneTextField?.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(self.phoneTextField!)
        
        self.sendbtn = UIButton(frame: CGRect(x: kScreenWidth - 20 - 50, y: 5, width: 45, height: 30))
        self.sendbtn!.setTitle("发送", forState: .Normal)
        self.sendbtn!.backgroundColor = UIColor.greenColor()
        self.sendbtn!.hidden = true
        self.sendbtn!.addTarget(self, action: "sendCode:", forControlEvents: .TouchUpInside)
        self.phoneTextField?.addSubview(self.sendbtn!)
        
        let btn = UIButton(frame: CGRect(x: 10, y: 210, width: kScreenWidth - 20, height: 40))
        btn.setTitle("注册", forState: .Normal)
        btn.backgroundColor = UIColor.greenColor()
        btn.addTarget(self, action: "register:", forControlEvents: .TouchUpInside)
        self.view?.addSubview(btn)
    }
    func segmentAction(segment:UISegmentedControl){
        
        let index = segment.selectedSegmentIndex
        
        switch index{
            
        case 0:
            self.nameTextField?.placeholder = "用户名"
            self.passWordTextField?.placeholder = "密码"
            self.phoneTextField?.placeholder = "邮箱"
            self.sendbtn!.hidden = true
        case 1:
            self.nameTextField?.placeholder = "手机号码"
            self.passWordTextField?.placeholder = "密码"
            self.phoneTextField?.placeholder = "验证码"
            self.sendbtn!.hidden = false
            
        default:
            break
            
        }
        
        print(index)
    }
    
    func sendCode(btn:UIButton){
        
        print("发送验证码")
        
        //手机注册
        print("注册\(index)")
        let user = AVUser()
        user.username = self.nameTextField?.text
        user.password = self.passWordTextField?.text
        user.mobilePhoneNumber = self.nameTextField?.text
        //            let error:NSError
        user.signUpInBackgroundWithBlock({ (succeeded:Bool, error:NSError!) -> Void in
            
        })
//        AVOSCloud.requestSmsCodeWithPhoneNumber(self.nameTextField?.text, appName: "NotePad", operation: "注册短信验证", timeToLive: 3) { (succeeded:Bool, error:NSError!) -> Void in
//            
//            if succeeded{
//                
//                print("短信发送成功")
//                
//            }else{
//                print(error)
//                
//            }
//            
//        }
    }
    
    func register(btn:UIButton){
        //获取选中的坐标
        let index = (self.segmentedControl?.selectedSegmentIndex)! as Int
        switch index {
        case 0:
            //帐号注册
//            print("注册\(index)")
            let user = AVUser()
            user.username = self.nameTextField?.text
            user.password = self.passWordTextField?.text
            user.email = self.phoneTextField?.text
            
            
            user.signUpInBackgroundWithBlock({ (succeeded:Bool, error:NSError!) -> Void in
                if succeeded{
                    //注册好 就已经登录了
                    ProgressHUD.showSuccess("注册成功，请验证邮箱")
                    self.navigationController?.popToRootViewControllerAnimated(true)

                }else{
                    
                    if error.code == 125{
                        ProgressHUD.showSuccess("邮箱不合法")
                    }else if error.code == 202{
                        ProgressHUD.showSuccess("用户名已存在")
                    }else if error.code == 203{
                        ProgressHUD.showSuccess("邮箱已注册")
                    }else{
                        ProgressHUD.showSuccess("注册失败，请重试")
                    }
                }
            })

        case 1:
            //手机注册
//            print("注册\(index)")
//            AVOSCloud.verifySmsCode(self.phoneTextField?.text, mobilePhoneNumber: self.nameTextField?.text, callback: { (succeeded:Bool, error:NSError!) -> Void in
//                
//                if succeeded{
                    //注册好 就已经登录了
                print("帐号注册成功，并且已经登陆")
                let user = AVUser()
                user.username = self.nameTextField?.text
                user.password = self.passWordTextField?.text
                user.mobilePhoneNumber = self.nameTextField?.text
                user.signUpInBackgroundWithBlock({ (succeeded:Bool, error:NSError!) -> Void in
                    
                })
                    
//                }else{
//                    print(error)
//                    
//                }
//            
//            })
            
        default:
            break
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 监听键盘弹出
    func keyboardDidShow(notification: NSNotification) {

        UIView.animateWithDuration(0.3) { () -> Void in
         
            var frame = self.view.frame
            frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64 - 49)
            self.view.frame = frame
            
        }
    }
    
    /// 监听键盘收回
    func keyboardWillHide(notification: NSNotification) {

        UIView.animateWithDuration(0.3) { () -> Void in
         
            var frame = self.view.frame
            frame = CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64 - 49)
            self.view.frame = frame
        }
    }

}
