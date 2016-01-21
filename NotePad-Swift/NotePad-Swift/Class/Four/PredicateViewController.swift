//
//  PredicateViewController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/1/21.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class PredicateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView?
    var searchController:UISearchDisplayController?
    var oldData:NSArray?
    var newData:NSArray?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        oldData = ["OC示例", "二维码", "地图", "电话，短信，邮件", "谓词搜索","新功能6", "新功能7", "新功能8", "新功能9", "新功能10", "haha"];
        
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
        }
        
    }
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
