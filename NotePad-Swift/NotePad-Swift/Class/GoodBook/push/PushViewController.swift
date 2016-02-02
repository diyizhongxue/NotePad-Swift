//
//  PushViewController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.setNavBar()
        
    }
    func setNavBar(){
        
        let navView = UIView(frame: CGRect(x: 0, y: -20, width: kScreenWidth, height: 65))
        navView.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.addSubview(navView)
        
        let addBookBtn = UIButton(frame: CGRect(x: 20, y: 20, width: 150, height: 45))
        addBookBtn.contentHorizontalAlignment = .Left //按钮文字 居左
        addBookBtn.setTitle("增加书评", forState: .Normal)
        addBookBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addBookBtn.titleLabel?.font = UIFont(name:"FZXingKai-S04", size: 20)
        addBookBtn.addTarget(self, action: "addBookBtn", forControlEvents: .TouchUpInside)
        navView.addSubview(addBookBtn)
        
    }
    
    func addBookBtn(){
        let vc = PushNewBookController()
        Common.addLeftBtn(vc, btnTitle: "关闭")
        Common.addRightBtn(vc, btnTitle: "确定")
        self.presentViewController(vc, animated: true) { () -> Void in
            
            
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
