//
//  TabBarController.swift
//  NotePad-Swift
//
//  Created by Silver on 15/12/27.
//  Copyright © 2015年 Silver. All rights reserved.
//

/*
tabBar自定义
动画
图片显示 模式
以图片为背景颜色




*/

import UIKit

class TabBarController: UITabBarController {
    
    var selectView:UIImageView?
    
//    class var sharedInstance:TabBarController{
//        
//        struct Static {
//            static var onceToken : dispatch_once_t = 0
//            static var instance : TabBarController? = nil
//        }
//        dispatch_once(&Static.onceToken) {
//            Static.instance = TabBarController()
//            
//        }
//        
//        return Static.instance!
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //都会以图片的大小显示
//        self.tabBar.backgroundImage = UIImage(named: "mask_detailbar.png")
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_home.jpg")!)
        self.tabBar.barTintColor = UIColor.blackColor()
        
        createTabBarView()
        createViewControllers()

    }
    func createTabBarView(){
        
        let imageNames = ["home_tab_icon_1.png","home_tab_icon_2.png","home_tab_icon_4.png","home_tab_icon_3.png","home_tab_icon_5.png"];
        let titles = ["主页","笔记","我的","闹钟","更多"];
        
        let tabBarView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 49))
//        tabBarView.image = UIImage(named: "mask_detailbar.png")
        tabBarView.userInteractionEnabled = true
        //以图片为背景颜色
        tabBarView.backgroundColor = UIColor(patternImage: UIImage(named: "mask_detailbar.png")!)
        //图片显示样式
//        tabBarView.contentMode = .ScaleAspectFill
        self.tabBar.addSubview(tabBarView)
        
        let itemWidth = kScreenWidth/CGFloat(titles.count)

        for i in 0..<5{
        
            let btn = UIButton(frame:CGRect(x:itemWidth * CGFloat(i), y:0, width:itemWidth, height:40))
//            btn.backgroundColor = UIColor.whiteColor()
            btn.setImage(UIImage(named:imageNames[i]), forState: UIControlState.Normal)
            btn.tag = i
            btn.addTarget(self, action: "selectedTab:", forControlEvents: UIControlEvents.TouchUpInside)
            tabBarView.addSubview(btn)
            
            
            let label = UILabel(frame: CGRect(x:itemWidth * CGFloat(i), y:40, width:itemWidth, height:8))
            label.text = titles[i]
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(8)
            tabBarView.addSubview(label)
            
            selectView = UIImageView(frame: CGRect(x:0, y:0, width:itemWidth, height:49))
            selectView?.image = UIImage(named: "home_bottom_tab_arrow.png")
            tabBarView.addSubview(selectView!)
            
        }
    }
    func createViewControllers(){
        
        let oneCol = NavigationViewController(rootViewController:OneViewController())
        self.addChildViewController(oneCol)
//        let item1 = UITabBarItem(title: "主页", image: UIImage(named: "home_tab_icon_1.png") , selectedImage: UIImage(named: "home_bottom_tab_arrow.png"))
//        oneCol.tabBarItem = item1
        
        let twoCol = NavigationViewController(rootViewController:TwoViewController())
        self.addChildViewController(twoCol)
//        let item2 = UITabBarItem(title: "主页", image: UIImage(named: "home_tab_icon_2.png") , selectedImage: UIImage(named: "home_bottom_tab_arrow.png"))
//        twoCol.tabBarItem = item2
        
        let threeCol = NavigationViewController(rootViewController:ThreeViewController())
        self.addChildViewController(threeCol)
//        let item3 = UITabBarItem(title: "主页", image: UIImage(named: "home_tab_icon_3.png") , selectedImage: UIImage(named: "home_bottom_tab_arrow.png"))
//        threeCol.tabBarItem = item3
        
        let fourCol = NavigationViewController(rootViewController:FourViewController())
        self.addChildViewController(fourCol)
//        let item4 = UITabBarItem(title: "主页", image: UIImage(named: "home_tab_icon_4.png") , selectedImage: UIImage(named: "home_bottom_tab_arrow.png"))
//        fourCol.tabBarItem = item4
        
        let fiveCol = NavigationViewController(rootViewController:FiveViewController())
        self.addChildViewController(fiveCol)
//        let item5 = UITabBarItem(title: "主页", image: UIImage(named: "home_tab_icon_5.png") , selectedImage: UIImage(named: "home_bottom_tab_arrow.png"))
//        fiveCol.tabBarItem = item5
        
        //let viewControllers = [oneCol,twoCol,threeCol,fourCol,fiveCol];
        //self.viewControllers = viewControllers;
    
    }
    //切换控制器
    func selectedTab(btn:UIButton){
        UIView.animateWithDuration(0.2, animations: {
            () -> Void in
            
            var frame = self.selectView?.frame
            frame?.origin.x = btn.center.x - kScreenWidth/10
            self.selectView?.frame = frame!
            
//            self.selectView?.center = btn.center
        })
        self.selectedIndex = btn.tag
    }
    
    //删除 原生 tabBar
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for view in self.tabBar.subviews {
            if (view is UIControl && !(view is UIButton)) {
                view.removeFromSuperview()
            }
        }
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
