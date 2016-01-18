//
//  LaunchViewController.swift
//  NotePad-Swift
//
//  Created by Silver on 15/12/27.
//  Copyright © 2015年 Silver. All rights reserved.
//

/*

for 循环
NSUserDefaults
引导图
广告页


*/

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        
        let isFirst = NSUserDefaults().objectForKey("iFirst") as? Bool
        print(isFirst)
        
        if (isFirst == false) {
        
            NSUserDefaults().setBool(true, forKey: "iFirst")
            showLaunchViews()
            
        }else{
            showImage()
        }
    }
    
    //引导图
    func showLaunchViews(){
        
        let scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:kScreenWidth, height:kScreenHeight))
        scrollView.contentSize = CGSize(width: kScreenWidth*5, height: kScreenHeight)
        scrollView.pagingEnabled = true
        self.view.addSubview(scrollView)
        
        //闭区间
        for i in 0...4{
        
            //引导图
            let imageView = UIImageView(frame: CGRect(x:kScreenWidth * CGFloat(i), y:0, width:kScreenWidth, height:kScreenHeight))
            scrollView.addSubview(imageView)
            
            let index = i + 1
            let imageName = "guide\(index)@2x.png"
            let image = UIImage(named: imageName)
            imageView.image = image
            
            //引导图 页码
            let imageView1 = UIImageView(frame: CGRect(x:kScreenWidth * CGFloat(i) + 50.0, y:kScreenHeight-50.0, width:kScreenWidth-100.0, height:30.0))
            scrollView.addSubview(imageView1)
            
            let index1 = i + 1
            let imageName1 = "guideProgress\(index1)@2x.png"
            let image1 = UIImage(named: imageName1)
            imageView1.image = image1
            
        }
        
        let button = UIButton(frame: CGRect(x:kScreenWidth * 4 + 100.0, y:kScreenHeight - 150.0, width:kScreenWidth - 200, height:30.0))
        button.backgroundColor=UIColor.orangeColor()
        button.setTitle("立即进入", forState: UIControlState.Normal)
        button.addTarget(self, action:"buttonAction", forControlEvents: UIControlEvents.TouchDragInside)
        scrollView.addSubview(button)
    
    }
    //显示 广告页面
    func showImage(){
        
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:kScreenWidth, height:kScreenHeight))
        self.view.addSubview(imageView)
        imageView.image = UIImage(named:"Default")
        
        imageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target:self, action:"imageAction")
        imageView.addGestureRecognizer(tap)
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector:"showMainView", userInfo: nil, repeats: false)
    }
    
    //立即进入按钮
    func buttonAction(){

        showMainView()
    }
    //显示主页面
    func showMainView(){
        
//        let tabBarCol = TabBarController.sharedInstance
        
        let tabBarCol = TabBarController()
        self.view.window?.rootViewController = tabBarCol
        
        let transfom = CGAffineTransformMakeScale(0.2, 0.2)
        tabBarCol.view.transform = transfom

        
        UIView.animateWithDuration(0.5, animations: {
            ()->Void in
            
            tabBarCol.view.transform = CGAffineTransformIdentity

            })
    
    }
    //进入广告页面
    func imageAction(){
    
        print("进入广告页面")
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
