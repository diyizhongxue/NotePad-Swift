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
        
    }
    
    func register(btn:UIButton){
        //获取选中的坐标
        let index = (self.segmentedControl?.selectedSegmentIndex)! as Int
        switch index {
        case 0:
            //帐号注册
            print("注册\(index)")
            let user = AVUser()
            user.username = self.nameTextField?.text
            user.password = self.passWordTextField?.text
            user.email = self.phoneTextField?.text
            
            
            user.signUpInBackgroundWithBlock({ (succeeded:Bool, error:NSError!) -> Void in
                if succeeded{
                    //注册好 就已经登录了
                    print("帐号注册成功，并且已经登陆")

                }else{
                    print(error)
                
                }
            })

        case 1:
            //手机注册
            print("注册\(index)")
            let user = AVUser()
            user.username = self.nameTextField?.text
            user.password = self.passWordTextField?.text
            user.mobilePhoneNumber = self.nameTextField?.text
            user.signUpInBackgroundWithBlock({ (succeeded:Bool, error:NSError!) -> Void in
                
            })
            
            
        default:
            break
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
