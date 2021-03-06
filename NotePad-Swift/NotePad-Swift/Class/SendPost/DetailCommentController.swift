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
    var dataArray = NSMutableArray()
    var inPutView:UIView?
    var page:Int = 1
    var model :OneModel?


    deinit{
        // 删除键盘监听
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
    }
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        
        self.getNewData()
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.title = "所有评论"
        creatViews()

        //初始刷新
        weak var weakSelf = self
        self.tableView?.addGifHeaderWithRefreshingBlock({ () -> Void in
            
            weakSelf?.getNewData()
        })
        
        let imagesArray = NSMutableArray()
        for i in 1...6{
            let imgName = "\(i).jpg"
            let img = UIImage(named: imgName)
            imagesArray.addObject(img!)
        }
        //不是正在刷新
        let firstImgArray = imagesArray.subarrayWithRange(NSRange(location: 0, length: 1))
        self.tableView?.gifHeader.setImages(firstImgArray, forState: MJRefreshHeaderStateIdle)
        
        //正在刷新
        self.tableView?.gifHeader.setImages(imagesArray as [AnyObject], forState: MJRefreshHeaderStateRefreshing)
        
        //下拉加载更多
        self.tableView?.addLegendFooterWithRefreshingBlock({ () -> Void in
            
            weakSelf?.getMoreData()
        })
        
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidShow:"), name:UIKeyboardDidShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidHide:"), name:UIKeyboardDidHideNotification, object: nil)

       
    }
    func getNewData(){
        
        let post = AVObject(withoutDataWithClassName: "Post", objectId: model!.postId)
        let query = AVQuery(className: "Comment")
        query.limit = 10; // 最多返回 10 条结果
        page = 1

        // 按发帖时间降序排列
//        query.orderByDescending("createdAt")
        query.whereKey("post", equalTo: post)
        query.findObjectsInBackgroundWithBlock { (array:[AnyObject]!, error:NSError!) -> Void in
           
            if array != nil{
                self.dataArray.removeAllObjects()
                self.dataArray.addObjectsFromArray(array as [AnyObject])
                self.tableView?.reloadData()
            }
        }
        
        //取消动画
        self.tableView?.header.endRefreshing()
    }
    func getMoreData(){
        //

        let post = AVObject(withoutDataWithClassName: "Post", objectId: model!.postId)
        let query = AVQuery(className: "Comment")
        query.limit = 10; // 最多返回 10 条结果
        query.skip = 10 * page; // 跳过前 10 条结果
        // 按发帖时间降序排列
//        query.orderByDescending("createdAt")
        query.whereKey("post", equalTo: post)
        query.findObjectsInBackgroundWithBlock { (array:[AnyObject]!, error:NSError!) -> Void in
            
            if array != nil{
                
                self.dataArray.addObjectsFromArray(array)
                self.tableView?.reloadData()
            }
        }
        
        page += 1
        self.tableView?.footer.endRefreshing()
    }

    func creatViews(){
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-64-49))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 190))
        headerView.backgroundColor = UIColor.purpleColor()
        
        let icon = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height:30))
        icon.backgroundColor = UIColor.redColor()
        icon.image = UIImage(named: "home_tab_icon_4")
        headerView.addSubview(icon)
        
        let nameLabel = UILabel(frame: CGRect(x: 40, y: 5, width: 100, height: 30))
        nameLabel.font = UIFont.systemFontOfSize(12)
        headerView.addSubview(nameLabel)
        
        let creatTimtLabel = UILabel(frame: CGRect(x: kScreenWidth - 155, y: 5, width: 150, height: 30))
        creatTimtLabel.font = UIFont.systemFontOfSize(12)
        creatTimtLabel.textAlignment = .Right
        headerView.addSubview(creatTimtLabel)
        
        let contentLabel = UILabel(frame: CGRect(x: 40, y: 40, width: kScreenWidth - 50, height: 30))
        //        self.contentLabel?.backgroundColor = UIColor.redColor()
        contentLabel.font = UIFont.systemFontOfSize(15)
        headerView.addSubview(contentLabel)
        
        let imgView = UIImageView(frame: CGRect(x: 100, y: 75, width: kScreenWidth - 200, height: kScreenWidth - 200))
        imgView.backgroundColor = UIColor.redColor()
        headerView.addSubview(imgView)
        
        if !model!.name.isEmpty{
            nameLabel.text = model!.name
        }else{
            nameLabel.text = "游客用户"
        }
        creatTimtLabel.text = model!.time
        contentLabel.text = model!.content
        contentLabel.numberOfLines = 0
        let size = Common.captureTextSizeWithText(model!.content, textWidth: kScreenWidth - 60, font: "15")
        contentLabel.frame.size = size

        var imgFrame = imgView.frame
        imgFrame.origin.y = 75 + size.height - 30
        imgView.frame = imgFrame
    
        var headerViewFrame = headerView.frame
        
        if model!.isImageExist {
            
            imgView.hidden = false
            imgView.image = model!.image
            
            headerViewFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: size.height + 60 + kScreenWidth - 200 + 5)
        }else{
            imgView.hidden = true
            headerViewFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: size.height + 60)
        }
        
        headerView.frame = headerViewFrame
        
        let lineView = UIView(frame: CGRect(x: 0, y: headerViewFrame.height - 5, width: kScreenWidth, height: 5))
        lineView.backgroundColor = UIColor.orangeColor()
        headerView.addSubview(lineView)
    
        self.tableView?.tableHeaderView = headerView
        
        self.inPutView = UIView(frame: CGRect(x: 0, y: kScreenHeight - 49 - 64, width: kScreenWidth, height: 49))
        self.inPutView?.backgroundColor = UIColor.grayColor()
        //插入 视图
        self.view.insertSubview(self.inPutView!, atIndex: 1)
        
        let textView = UITextView(frame: CGRect(x: 5, y: 5, width: kScreenWidth - 55, height: 40))
        textView.delegate = self
        textView.tag = 101
        textView.backgroundColor = UIColor.redColor()
        self.inPutView?.addSubview(textView)
        
        
        let btn = UIButton(frame: CGRect(x: kScreenWidth - 50, y: 5, width: 45, height: 40))
        btn.backgroundColor = UIColor.greenColor()
        btn.setTitle("发送", forState: .Normal)
        btn.addTarget(self, action: "sendComment:", forControlEvents: .TouchUpInside)
        self.inPutView?.addSubview(btn)
        
        Common.addNavRightBtn(self, btnTitle: "收藏")
    }
    func makeSure(){
    
        let user = AVUser.currentUser()
        user.addUniqueObject(model!.postId, forKey: "myCollection")
        //        user.addObjectsFromArray( forKey: "myCollection")
        
        user.saveInBackgroundWithBlock { (succeeded:Bool, error:NSError!) -> Void in
            if succeeded{
                ProgressHUD.showSuccess("收藏成功")

            }else{
                
            }
            
        }
    }

    
    func sendComment(btn:UIButton){
        
        let textView = self.inPutView?.viewWithTag(101) as! UITextView
        textView.resignFirstResponder()

        let post = AVObject(withoutDataWithClassName: "Post", objectId: model!.postId)
        let myComment = AVObject(className: "Comment")
        myComment.setObject(textView.text, forKey: "comment")
        myComment.setObject(post, forKey: "post")
        myComment.setObject(AVUser.currentUser(), forKey: "user")
        myComment.saveInBackgroundWithBlock { (succeeded:Bool, error:NSError!) -> Void in
            
            if succeeded{
                // post 保存成功
                ProgressHUD.showSuccess("评论成功")
                self.getNewData()
            }else{
                
                // 保存 post 时出错
                print(error)
            }
        }
        
        textView.text = ""
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
//        print("键盘已经弹出")
        
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        let rawFrame = value.CGRectValue
//        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        var frame = self.inPutView?.frame
        frame? = CGRect(x: 0, y: kScreenHeight - 49 - 64 - rawFrame.size.height, width: kScreenWidth, height: 49)
        self.inPutView?.frame = frame!
    }
    
    /// 监听键盘收回
    func keyboardWillHide(notification: NSNotification) {
//        print("键盘已经收回")
//        let info  = notification.userInfo!
//        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
//        let rawFrame = value.CGRectValue
        //        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        var frame = self.inPutView?.frame
        frame? = CGRect(x: 0, y: kScreenHeight - 49 - 64, width: kScreenWidth, height: 49)
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
