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
    var nameArray:NSArray?
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        nameArray = ["OC示例", "二维码", "地图", "电话，短信，邮件", "新功能6","新功能6", "新功能7", "新功能8", "新功能9", "新功能10"];
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        creatViews()
        
        
    }
    
    func creatViews(){
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (nameArray?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if (cell == nil) {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = nameArray![indexPath.row] as? String

        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                 //已经登录
            switch indexPath.row{
    
            case 0:
                let listOneCol = ListOneController()
                self.navigationController?.pushViewController(listOneCol, animated: true)
                
                break
            case 1:
                
                break
            case 2:
                
                break
            case 3:
                
                break
            case 4:
                
                break
            case 5:
                
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
