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

*/

import UIKit

class OneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

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
        //        query.skip = 10; // 跳过前 10 条结果
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
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        btn.setTitle("发帖子", forState: .Normal)
        btn.backgroundColor = UIColor.greenColor()
        btn.addTarget(self, action: "sendPost:", forControlEvents: .TouchUpInside)
//        self.navigationController?.navigationBar.addSubview(btn)
        let item = UIBarButtonItem(customView: btn)
        self.navigationItem.leftBarButtonItem = item
    }
    
    func sendPost(btn:UIButton){
        
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
        vc.postId = model.postId
//        print(model.postId)

        //隐藏 tabBar
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
 
        let model = self.dataArray[indexPath.row] as! OneModel
        let size = captureTextSizeWithText(model.content, textWidth: kScreenWidth - 60, font: "15")
        if model.isImageExist {

            return size.height + 60 + kScreenWidth - 200 + 5

        }else{

            return size.height + 60
        }
    }
    
    func captureTextSizeWithText(text:NSString, textWidth width:CGFloat, font:String)->CGSize{
        
        let constraint = CGSize(width: width, height: 20000.0)
        let tdic = [font:NSFontAttributeName]
        let rect = text.boundingRectWithSize(constraint, options:NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: tdic, context: nil)
        
        let size = CGSizeMake(kScreenWidth - 50, rect.size.height + 20)
        
        return size
        
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
