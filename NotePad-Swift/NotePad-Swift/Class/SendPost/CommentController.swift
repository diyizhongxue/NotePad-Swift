//
//  CommentController.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/6.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*


*/

import UIKit

class CommentController: UIViewController, UITextViewDelegate {

    var textView:UITextView?
    var postId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None

//        print(self.postId)
        creatViews()
    }
    func creatViews(){

        self.textView = UITextView(frame: CGRect(x: 0, y: 10, width: kScreenWidth, height: 100))
        self.textView?.backgroundColor = UIColor.whiteColor()
        self.textView?.delegate = self
        self.textView?.text = "请不要少于1个字"
        self.view.addSubview(self.textView!)
        
        let sureBtn = UIButton(frame: CGRect(x: 10, y: 120, width: kScreenWidth - 20, height: 44))
        sureBtn.setTitle("评论", forState: .Normal)
        sureBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        sureBtn.backgroundColor = UIColor.greenColor()
        sureBtn.addTarget(self, action: "makeSure:", forControlEvents: .TouchUpInside)
        self.view.addSubview(sureBtn)
        
    }
    func makeSure(btn:UIButton){
        
        let post = AVObject(withoutDataWithClassName: "Post", objectId: self.postId)
        
        let myComment = AVObject(className: "Comment")
        myComment.setObject(self.textView?.text, forKey: "comment")
        myComment.setObject(post, forKey: "post")
        myComment.setObject(AVUser.currentUser(), forKey: "user")
        myComment.saveInBackgroundWithBlock { (succeeded:Bool, error:NSError!) -> Void in
            
            if succeeded{
                // post 保存成功
            }else{
                
                // 保存 post 时出错
                print(error)
            }
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    func textViewShouldBeginEditing(textView: UITextView) -> Bool{
        
        textView.text = ""
        return true
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
