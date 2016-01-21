//
//  ChannelViewController.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/4.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*
push正向传值 一定要用 self.channelData 否则取不到 数据

代理反向传值

动画

*/

import UIKit
import QuartzCore

protocol ChannelDelegate{

    func onChangeChannel(channel_id:String)
}

class ChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var channelData = NSArray()
    var delegate:ChannelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channelData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "channel")
        let rowData = self.channelData[indexPath.row] as! NSDictionary
        cell.textLabel?.text = rowData["name"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let rowData = self.channelData[indexPath.row] as! NSDictionary
        let channel_id = rowData["channel_id"]! as AnyObject
        let channel:String = "channel=\(channel_id)"
        delegate?.onChangeChannel(channel)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    //cell显示动画
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25) { () -> Void in
        
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }


}
