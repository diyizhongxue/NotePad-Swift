//
//  RankViewController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class RankViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orangeColor()
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        btn.setTitle("返回", forState: .Normal)
        btn.backgroundColor = UIColor.greenColor()
        btn.addTarget(self, action: "goBack:", forControlEvents: .TouchUpInside)
        let item = UIBarButtonItem(customView: btn)
        self.navigationItem.leftBarButtonItem = item
    }
    
    func goBack(btn:UIButton){
        let tabBarCol =  TabBarController()
        tabBarCol.selectedIndex = 3
        self.view.window?.rootViewController = tabBarCol
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
