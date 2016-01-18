
//  Created by Silver on 15/12/27.
//  Copyright © 2015年 Silver. All rights reserved.
//

/*
获取三个特殊属性：
NSString *objectId = post.objectId;
NSDate *updatedAt = post.updatedAt;
NSDate *createdAt = post.createdAt;

如果需要刷新特定对象的最新数据，可调用 refresh 方法 ：
[myObject refresh];

[post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
if (!error) {
// post 保存成功
} else {
// 保存 post 时出错
}
}];
+
或者写成回调方式：
+

// 先创建一个回调
- (void)saveCallback:(NSNumber *)result error:(NSError *)error {
if (!error) {
// post 保存成功
} else {
// 保存 post 时出错
}
}

// 然后在后续代码中执行其他操作
[post saveInBackgroundWithTarget:self
selector:@selector(saveCallback:error:)];
*/

import UIKit

class TwoViewController: UIViewController, SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    var tableView:UITableView?

    override func viewDidLoad() {
        
        self.edgesForExtendedLayout = .None
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        self.title = "LeanCloud"
        
        
        creatViews()
    }
    func creatViews(){

        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-64-49))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)

        }
        
        if indexPath.row == 0{

            let img1 = UIImage(named:"h1.jpg")
            let img2 = UIImage(named:"h2.jpg")
            let img3 = UIImage(named:"h3.jpg")
            let img4 = UIImage(named:"h4.jpg")

            let images = [img1 as! AnyObject,img2 as! AnyObject,img3 as! AnyObject,img4 as! AnyObject];

            let titles = ["百度","百度贴吧","qq空间","新浪微博"];

            let cycleScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 180), imagesGroup: images)
            cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
            cycleScrollView.delegate = self
            cycleScrollView.autoScrollTimeInterval = 2.0
            cycleScrollView.titlesGroup = titles
            cell!.addSubview(cycleScrollView)

        }else if indexPath.row == 1{
            cell?.backgroundColor = UIColor.purpleColor()
            cell?.textLabel?.text = "豆瓣电台"
            cell?.accessoryType = .DisclosureIndicator
            
        }

        
        
        return cell!
        
    }
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 1{
            
            let storyboard = UIStoryboard(name: "Douban", bundle: NSBundle.mainBundle())
            let douBanVC = storyboard.instantiateViewControllerWithIdentifier("DoubanViewController")
            douBanVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(douBanVC, animated: true)
            
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0{

            return 180
        }else{
        
            return 60
        }
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool{
        
        textView.becomeFirstResponder()
    
        return true
    }
    
    //MARK: 点击 轮播图
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        print("\(index)")
        //
        //        let post = AVObject(className: "Post")
        //        post.setObject("\(index)", forKey: "neirong")
        //        post.addUniqueObjectsFromArray(["这是","一条", "微博"], forKey: "tags")
        ////        post.saveInBackgroundWithBlock { (succeeded:Bool, error:NSError!) -> Void in
        ////            if succeeded{
        ////                // post 保存成功
        ////            }else{
        ////                // 保存 post 时出错
        ////            }
        ////        }
        //
        //        let myComment = AVObject(className: "Comment")
        //        myComment.setObject("作为一个程序员，你认为回家以后要不要继续写代码？", forKey: "content")
        //        myComment.setObject(post, forKey: "post")
        //        myComment.addUniqueObjectsFromArray(["这是", "评论"], forKey: "tags")
        //
        //        myComment.saveInBackgroundWithBlock { (succeeded:Bool, error:NSError!) -> Void in
        //            if succeeded{
        //                // post 保存成功
        //            }else{
        //                // 保存 post 时出错
        //            }
        //        }
        
    }
    
//    func textViewDidEndEditing(textView: UITextView){
//    
//        textView.resignFirstResponder()
//    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
