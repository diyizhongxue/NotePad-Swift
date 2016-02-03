//
//  FourViewController.swift
//  NotePad-Swift
//
//  Created by Silver on 15/12/27.
//  Copyright © 2015年 Silver. All rights reserved.
//

import UIKit

class FourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    var tableView:UITableView?
    var searchController:UISearchDisplayController?

    var oldData:NSArray?
    var newData:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        
        oldData = ["OC示例", "二维码", "地图", "电话，短信，邮件", "好书","豆瓣电台", "新功能7", "新功能8", "新功能9", "新功能10"];
        
        creatViews()
        
        
    }
    
    func creatViews(){
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        searchBar.placeholder = "搜索"
        self.tableView?.tableHeaderView = searchBar
        
        searchController = UISearchDisplayController(searchBar: searchBar, contentsController: self)
        searchController?.searchResultsDataSource = self
        searchController?.searchResultsDelegate = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView{
            return (oldData?.count)!
            
        }else{
            //谓词其他搜索样式  百度一下
            let predicate = NSPredicate(format: "self contains [cd] %@", (searchController?.searchBar.text)!)
            newData = NSArray(array: (oldData?.filteredArrayUsingPredicate(predicate))!)
            
            return (newData?.count)!
        }    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if (cell == nil) {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        
        if tableView == self.tableView{
            cell?.textLabel?.text = oldData![indexPath.row] as? String
        }else{
            cell?.textLabel?.text = newData![indexPath.row] as? String
        }
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            switch indexPath.row{
    
            case 0:
                //OC示例
                let listOneCol = ListOneController()
                self.navigationController?.pushViewController(listOneCol, animated: true)
                
                break
            case 1:
                //"二维码"

                break
            case 2:
                //"地图"
                
                break
            case 3:
                //"电话，短信，邮件"
  
                break
            case 4:
                //好书 跳转另一个tabBarController
                self.view.window?.rootViewController = GBTabBarController()
                
                break
            case 5:
                
                let storyboard = UIStoryboard(name: "Douban", bundle: NSBundle.mainBundle())
                let douBanVC = storyboard.instantiateViewControllerWithIdentifier("DoubanViewController")
                douBanVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(douBanVC, animated: true)
                
                
                break
            case 6:
                
                break
            case 7:
                
                break
            case 8:
                
                break
            case 9:
                
                break
            default:
                break
            }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
