//
//  GBTabBarController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class GBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        UITabBarSystemItemMore,
        //        UITabBarSystemItemFavorites,
        //        UITabBarSystemItemFeatured,
        //        UITabBarSystemItemTopRated,
        //        UITabBarSystemItemRecents,
        //        UITabBarSystemItemContacts,
        //        UITabBarSystemItemHistory,
        //        UITabBarSystemItemBookmarks,
        //        UITabBarSystemItemSearch,
        //        UITabBarSystemItemDownloads,
        //        UITabBarSystemItemMostRecent,
        //        UITabBarSystemItemMostViewed,
        
        let one = UINavigationController(rootViewController: RankViewController())
        let two = UINavigationController(rootViewController: SearchViewController())
        let three = UINavigationController(rootViewController: PushViewController())
        let four = UINavigationController(rootViewController: CircleViewController())
        let five = UINavigationController(rootViewController: MoreViewController())
        
        let viewCols = [one, two, three, four, five]
        
        let item1 = UITabBarItem(tabBarSystemItem: .Favorites, tag: 0)
        let item2 = UITabBarItem(tabBarSystemItem: .Search, tag: 1)
        let item3 = UITabBarItem(tabBarSystemItem: .MostViewed, tag: 2)
        let item4 = UITabBarItem(tabBarSystemItem: .Bookmarks, tag: 3)
        let item5 = UITabBarItem(tabBarSystemItem: .More, tag: 4)
        
        one.tabBarItem = item1
        two.tabBarItem = item2
        three.tabBarItem = item3
        four.tabBarItem = item4
        five.tabBarItem = item5


        self.viewControllers = viewCols
    
        
        // Do any additional setup after loading the view.
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
