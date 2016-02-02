//
//  PushNewBookController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class PushNewBookController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        creatViews()
    }
    func creatViews(){
    
        let bookTitleView = BookTitleView(frame:CGRect(x: 0, y: 50, width: kScreenWidth, height: 140))
        bookTitleView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(bookTitleView)
    }
    
    func colse(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    func sure(){
        
       print("sure")
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
