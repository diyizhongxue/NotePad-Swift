//
//  PushNewBookController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class PushNewBookController: UIViewController, BookCoverDelegate, PhotoPickerDelegate {
    
    var bookTitleView:BookTitleView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        
        creatViews()
    }
    func creatViews(){
    
        bookTitleView = BookTitleView(frame:CGRect(x: 0, y: 50, width: kScreenWidth, height: 130))
        bookTitleView?.backgroundColor = UIColor.grayColor()
        bookTitleView?.delegate = self
        self.view.addSubview(bookTitleView!)
    }
    
    func colse(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    func sure(){
        
       print("sure")
    }
    func bookCoverClick() {
        
        if #available(iOS 8.0, *) {
            let vc = PhotoPickerController()
            vc.delegate = self
            self.presentViewController(vc, animated: true, completion: { () -> Void in
            })
        } else {
            
        }
        
    }
    func getImageFromPicker(image: UIImage) {
        
        self.bookTitleView?.bookCover?.setImage(image, forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
