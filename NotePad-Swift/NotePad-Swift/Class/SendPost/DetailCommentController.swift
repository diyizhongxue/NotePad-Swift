//
//  DetailCommentController.swift
//  NotePad-Swift
//
//  Created by Silveron 16/1/6.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*
插入 视图

NSNotificationCenter

*/

import UIKit

class DetailCommentController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{

    var tableView:UITableView?
    var dataArray = NSArray()
    var postId:String?
    var inPutView:UIView?


//    deinit{
//        // 删除键盘监听
//        print("删除键盘监听")
//        NSNotificationCenter.defaultCenter().removeObserver(self)
//    
//    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.title = "所有评论"
        
        getData()
        creatViews()
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidShow:"), name:UIKeyboardDidShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidHide:"), name:UIKeyboardDidHideNotification, object: nil)
//        
       
    }
    func getData(){
        
        let post = AVObject(withoutDataWithClassName: "Post", objectId: self.postId)
//        print(self.postId)
        let query = AVQuery(className: "Comment")
        query.whereKey("post", equalTo: post)
        query.findObjectsInBackgroundWithBlock { (array:[AnyObject]!, error:NSError!) -> Void in
           
            if array != nil{
                self.dataArray = array
                self.tableView?.reloadData()
            }

        }
    }
    func creatViews(){
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-64-49))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
        
        self.inPutView = UIView(frame: CGRect(x: 0, y: kScreenHeight - 49 - 64, width: kScreenWidth, height: 49))
        self.inPutView?.backgroundColor = UIColor.grayColor()
        //插入 视图
        self.view.insertSubview(self.inPutView!, atIndex: 1)
        
        let textView = UITextView(frame: CGRect(x: 5, y: 5, width: kScreenWidth - 55, height: 40))
        textView.delegate = self
        textView.backgroundColor = UIColor.redColor()
        self.inPutView?.addSubview(textView)
        
        let btn = UIButton(frame: CGRect(x: kScreenWidth - 50, y: 5, width: 45, height: 40))
        btn.backgroundColor = UIColor.greenColor()
        btn.setTitle("发送", forState: .Normal)
        btn.addTarget(self, action: "sendComment:", forControlEvents: .TouchUpInside)
        self.inPutView?.addSubview(btn)
        
        let collectionBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        collectionBtn.setTitle("收藏", forState: .Normal)
        collectionBtn.backgroundColor = UIColor.greenColor()
        collectionBtn.addTarget(self, action: "collectionBtn:", forControlEvents: .TouchUpInside)
        //        self.navigationController?.navigationBar.addSubview(btn)
        let item = UIBarButtonItem(customView: collectionBtn)
        self.navigationItem.rightBarButtonItem = item
    }
    
    func collectionBtn(btn:UIButton){
        

        let user = AVUser.currentUser()
        user.addUniqueObject(self.postId!, forKey: "myCollection")
//        user.addObjectsFromArray( forKey: "myCollection")
        
        user.saveInBackgroundWithBlock { (succeeded:Bool, error:NSError!) -> Void in
            if succeeded{
            
                print("收藏成功")
            }else{
            
            }
            
        }
    }
    
    func sendComment(btn:UIButton){
        let vc = CommentController()
        vc.postId = self.postId
        self.navigationController?.pushViewController(vc, animated: true)
        self.view.endEditing(false)
        
//        self.inPutView?.resignFirstResponder()
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if (cell == nil) {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
            
        }
        let comment:AVObject = self.dataArray[indexPath.row] as! AVObject
        if comment.objectForKey("comment") != nil{
        
            let str = comment.objectForKey("comment") as! String
            cell?.textLabel?.text = str
        }else{
        
        }
 
        return cell!
    }
    func textViewDidBeginEditing(textView: UITextView) {
        
        self.inPutView?.becomeFirstResponder()
        
    }
    
    /// 监听键盘弹出
    func keyboardDidShow(notification: NSNotification) {
        print("键盘已经弹出")
        
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        let rawFrame = value.CGRectValue
//        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        var frame = self.inPutView?.frame
        frame?.origin.y -= rawFrame.size.height
        self.inPutView?.frame = frame!
    }
    
    /// 监听键盘收回
    func keyboardDidHide(notification: NSNotification) {
        print("键盘已经收回")
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        let rawFrame = value.CGRectValue
        //        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        var frame = self.inPutView?.frame
        frame?.origin.y += rawFrame.size.height
        self.inPutView?.frame = frame!
    }
    
//    func textViewShouldBeginEditing(textView: UITextView) -> Bool{
//        
//        self.inPutView?.becomeFirstResponder()
//        
//        return true
//    }
    
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
