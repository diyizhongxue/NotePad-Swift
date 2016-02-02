//
//  FiveViewController.swift
//  NotePad-Swift
//
//  Created by Silver on 15/12/27.
//  Copyright © 2015年 Silver. All rights reserved.
//

import UIKit

class FiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tableView:UITableView?
    var str :String?
    var array : NSArray?
    var currentUser : AVUser?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        currentUser = AVUser.currentUser()
        
        if currentUser != nil{
            str = "用户：\(currentUser!.username)"
        }else{
            str = "用户：请登录"
        }
        array = [str!, "我发布的帖子", "我收藏的帖子", "修改资料", "先留着"]
        
        self.tableView?.reloadData()
    }
    
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
        
        Common.addNavRightBtn(self, btnTitle: "设置")
    }
    func makeSure(){
        self.navigationController?.pushViewController(SettingViewController(), animated: true)

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if (cell == nil) {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = array![indexPath.row] as? String
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if currentUser != nil{
            //已经登录
            switch indexPath.row{
                
            case 0:
                
                //                self.navigationController?.pushViewController(LogInController(), animated: true)
                break
            case 1:
                
                self.navigationController?.pushViewController(MyPostViewController(), animated: true)
                
            case 2:
                self.navigationController?.pushViewController(MyCollectionPostController(), animated: true)
            case 3:
                
                break
            case 4:
                //退出
                break
            default:
                break
            }
            
            
        }else{
            //去登录
            self.navigationController?.pushViewController(LogInController(), animated: true)
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
