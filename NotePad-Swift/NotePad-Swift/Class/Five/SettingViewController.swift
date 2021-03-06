//
//  SettingViewController.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/18.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tableView:UITableView?
    let array = ["修改密码", "忘记密码", "退出"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        
        creatViews()
        
    }
    
    func creatViews(){
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
 
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if (cell == nil) {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = array[indexPath.row]
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentUser = AVUser.currentUser()
        
        //        print(currentUser.username)
        
        switch indexPath.row{
            
        case 0:
            if currentUser != nil{
                //已经登录
                //修改密码
                self.navigationController?.pushViewController(PassWordChangeController(), animated: true)
            }else{
                
                self.navigationController?.pushViewController(LogInController(), animated: true)
                
            }
        case 1:
            //忘记密码
            self.navigationController?.pushViewController(GorgetPassWordController(), animated: true)
        case 2:
            //退出
            AVUser.logOut()
            
        case 3:
            break
        case 4:
            break
        default:
            break
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
