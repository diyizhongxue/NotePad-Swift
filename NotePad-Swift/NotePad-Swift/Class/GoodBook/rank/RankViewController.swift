//
//  RankViewController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*
字体引入
info.plist
名字 直接在桌面打开看名字 不是直接看到的名字
label.font = UIFont(name: "FZXingKai-S04", size: 18)


*/

import UIKit

class RankViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 50, width: 300, height: 50))
        label.textAlignment = .Center
        label.text = "哈哈哈哈哈哈"
        label.textColor = UIColor.redColor()
        label.font = UIFont(name: MY_FONT, size: 18)
        self.view.addSubview(label)
        
        Common.addNavLeftBtn(self, btnTitle: "返回")
        Common.addNavRightBtn(self, btnTitle: "确定")

    }
    
    func goBack(){
        let tabBarCol =  TabBarController()
        tabBarCol.selectedIndex = 3
        self.view.window?.rootViewController = tabBarCol
    }
    func makeSure(){
        print("makeSure")

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
