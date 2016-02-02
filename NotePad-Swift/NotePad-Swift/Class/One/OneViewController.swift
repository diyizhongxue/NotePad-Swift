//
//  OneViewController.swift
//  NotePad-Swift
//
//  Created by Silver on 15/12/27.
//  Copyright © 2015年 Silver. All rights reserved.
//

/*
轮播图
tableView
cell点击不变色
cell的右箭头  

cell 子类化

tableView上下不能滑动
tableView不显示横线

隐藏 tabBar

加载storyboard
navigationItem

NSDate

UIAlertController
UIAlertView
UIActionSheet

*/

import UIKit

class OneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate{

    let cellId = "homeCell"

    var tableView :UITableView?
    var dataArray = NSMutableArray()
    var page:Int = 1
    

    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        
        getNewData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "主页"

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
    }
    
    func getNewData(){
    
        let array = NSMutableArray()
        let query = AVQuery(className: "Post")
        query.limit = 10; // 最多返回 10 条结果
        page = 1
        // 按发帖时间升序排列
        //        query.orderByAscending("createdAt")
        // 按发帖时间降序排列
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock({ (arr:[AnyObject]!, error:NSError!) -> Void in
            
            for item in arr{
                
                let model = OneModel()
                let post = item as! AVObject
                
                let str = post.objectForKey("content") as! String
                model.content = str
                
                if post.objectForKey("image") != nil{
                    
                    let file = post.objectForKey("image") as! AVFile
                    let data = file.getData()
                    let image = UIImage(data: data)
                    
                    model.image = image!
                    model.isImageExist = true
                }
                
                if post.objectForKey("uname") != nil{
                    let uname = post.objectForKey("uname") as? String
                    model.name = uname!
                }
                
                let creatDate = post.objectForKey("createdAt") as? NSDate
                let dateFmt = NSDateFormatter()
                dateFmt.locale = NSLocale(localeIdentifier: "zh_CN")
                dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ss"  // HH 代表 24 时 计时法
                let creatTime = dateFmt.stringFromDate(creatDate!)
                model.time = creatTime

                model.postId = post.objectId

                array.addObject(model)
            }
            self.dataArray.removeAllObjects()
            self.dataArray.addObjectsFromArray(array as [AnyObject])

            self.tableView?.reloadData()
        })

        //取消动画
        self.tableView?.header.endRefreshing()
    }
    func getMoreData(){
        
        let query = AVQuery(className: "Post")
        query.limit = 10; // 最多返回 10 条结果
        query.skip = 10 * page; // 跳过前 10 条结果
        // 按发帖时间降序排列
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock({ (arr:[AnyObject]!, error:NSError!) -> Void in

            for item in arr{
                
                let model = OneModel()
                let post = item as! AVObject
                
                let str = post.objectForKey("content") as! String
                model.content = str
                
                if post.objectForKey("image") != nil{
                    let file = post.objectForKey("image") as! AVFile
                    let data = file.getData()
                    let image = UIImage(data: data)
                    
                    model.image = image!
                    model.isImageExist = true
                }
                
                if post.objectForKey("uname") != nil{
                    let uname = post.objectForKey("uname") as? String
                    model.name = uname!
                }
                
                let creatDate = post.objectForKey("createdAt") as? NSDate
                let dateFmt = NSDateFormatter()
                dateFmt.locale = NSLocale(localeIdentifier: "zh_CN")
                dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ss"  // HH 代表 24 时 计时法
                let creatTime = dateFmt.stringFromDate(creatDate!)
                model.time = creatTime
                
                model.postId = post.objectId
                
                self.dataArray.addObject(model)
            }
            
            self.tableView?.reloadData()
        })
        

        page += 1
        self.tableView?.footer.endRefreshing()
    }
    
    func creatViews(){
        
        tableView = UITableView(frame: self.view.bounds, style:UITableViewStyle.Plain)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        //tableView上下不能滑动
//        tableView?.scrollEnabled = false
        //tableView不显示横线
        tableView?.separatorStyle = .None
        self.tableView!.registerClass(OneCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(tableView!)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 190))
        headerView.backgroundColor = UIColor.grayColor()
        let img1 = UIImage(named:"h1.jpg")
        let img2 = UIImage(named:"h2.jpg")
        let img3 = UIImage(named:"h3.jpg")
        let img4 = UIImage(named:"h4.jpg")
        let images = [img1 as! AnyObject,img2 as! AnyObject,img3 as! AnyObject,img4 as! AnyObject];
        let titles = ["豆瓣电台","AlertView","ActionSheet","新浪微博"];
        let cycleScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 180), imagesGroup: images)
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        cycleScrollView.delegate = self
        cycleScrollView.autoScrollTimeInterval = 2.0
        cycleScrollView.titlesGroup = titles
        headerView.addSubview(cycleScrollView)
        self.tableView?.tableHeaderView = headerView
        
        Common.addNavLeftBtn(self, btnTitle: "发帖子")
    }
    func goBack(){
        let sendPostCol = UINavigationController(rootViewController: SendPostController())
        self.presentViewController(sendPostCol, animated: true) { () -> Void in
            
        }
    }

    
    //MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
    
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! OneCell

        //cell的右箭头
        cell.accessoryType = .None
        cell.model = self.dataArray[indexPath.row] as! OneModel
        //cell点击不变色
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let model:OneModel = self.dataArray[indexPath.row] as! OneModel
        //评论
        let vc = DetailCommentController()
//        vc.postId = model.postId
        vc.model = model

        //隐藏 tabBar
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
 
        let model = self.dataArray[indexPath.row] as! OneModel
        let size = Common.captureTextSizeWithText(model.content, textWidth: kScreenWidth - 60, font: "15")
        if model.isImageExist {

            return size.height + 60 + kScreenWidth - 200 + 5

        }else{

            return size.height + 60
        }
    }
    //MARK: 点击 轮播图
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        switch index{
            
        case 0:
            
            let storyboard = UIStoryboard(name: "Douban", bundle: NSBundle.mainBundle())
            let douBanVC = storyboard.instantiateViewControllerWithIdentifier("DoubanViewController")
            douBanVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(douBanVC, animated: true)
            
        case 1:

                if #available(iOS 8.0, *) {
                    //1, 创建控件  包含： 主题 信息 样式
                    let alertController = UIAlertController(title: "Alert", message: "第二项", preferredStyle: .Alert)
                    
                    let showBtn = UIAlertAction(title: "show", style: .Destructive, handler: { (action:UIAlertAction) -> Void in
                        
                        print("并不会执行")
                    })
                    showBtn.enabled = false
                    alertController.addAction(showBtn)

                    
                    //2, 创建按钮 取消样式UIAlertActionStyleCancel
                    let cancelBtn = UIAlertAction(title: "cancel", style: .Cancel, handler: { (action:UIAlertAction) -> Void in
                        
                        print("UIAlertController---cancel")
                    })
                    alertController.addAction(cancelBtn)
                   
                    let sureBtn = UIAlertAction(title: "sure", style: .Destructive, handler: { (action:UIAlertAction) -> Void in
                        
                        print("UIAlertController---sure")
                    })
                    alertController.addAction(sureBtn)
                    //3, 添加 UITextField  只有alertView可以添加 actionSheet不能添加 需要判断
                    if alertController.preferredStyle == .Alert{
                    
                        alertController.addTextFieldWithConfigurationHandler({ (textField:UITextField) -> Void in
                            
                            textField.placeholder = "请输入用户名"
                            textField.textAlignment = .Center
                        })
                        alertController.addTextFieldWithConfigurationHandler({ (textField:UITextField) -> Void in
                            
                            textField.placeholder = "请输入用户名"
                            textField.textAlignment = .Center
                            textField.secureTextEntry = true
                            //背景不好看
                            textField.backgroundColor = UIColor.grayColor()
                            //改变输入框的 大小
                            textField.font = UIFont.systemFontOfSize(20)
                        })
                    }
                    //4，模态视图 方式显示出来
                    self.presentViewController(alertController, animated: true, completion: { () -> Void in
                    })
                    
                } else {
                    let alertView = UIAlertView(title: "第二", message: "第二项", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
                    alertView.show()
                }

        case 2:
            
            if #available(iOS 8.0, *) {
                let alertController = UIAlertController(title: "ActionSheet", message: "第二项", preferredStyle: .ActionSheet)
                
                let showBtn = UIAlertAction(title: "show", style: .Destructive, handler: { (action:UIAlertAction) -> Void in
                    
                    print("并不会执行")
                })
                showBtn.enabled = false
                alertController.addAction(showBtn)
                let cancelBtn = UIAlertAction(title: "cancel", style: .Cancel, handler: { (action:UIAlertAction) -> Void in
                    
                    print("UIAlertController---cancel")
                })
                alertController.addAction(cancelBtn)
                
                let sureBtn = UIAlertAction(title: "sure", style: .Destructive, handler: { (action:UIAlertAction) -> Void in
                    
                    print("UIAlertController---sure")
                })
                alertController.addAction(sureBtn)
                //4，模态视图 方式显示出来
                self.presentViewController(alertController, animated: true, completion: { () -> Void in
                })

            } else {
                let actionSheet = UIActionSheet(title: "actionSheet", delegate: self, cancelButtonTitle: "cencel", destructiveButtonTitle: "sure", otherButtonTitles: "other")
                actionSheet.showInView(self.view)
            
            }
        default:
            break
        }
    }
    //MARK: -UIAlertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
    
        print(buttonIndex)
    }
    //MARK: -UIActionSheetDelegate
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int){
        print(buttonIndex)

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
