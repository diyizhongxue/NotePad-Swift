//
//  PushNewBookController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/2.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*
剪裁图片
去掉 tableView 下面多余 的线
tableView 动态 插入 cell

*/

import UIKit

class PushNewBookController: UIViewController, BookCoverDelegate, PhotoPickerDelegate, VPImageCropperDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var bookTitleView:BookTitleView?
    var tableView:UITableView?
    var titleArray:Array<String> = []
    
    var book_title:String = ""
    var isShowScore = false
    var ratingView:RatingView?
    
    var type:String = "文学"
    var detailType:String = "文学"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatViews()
    }
    func creatViews(){
    
        bookTitleView = BookTitleView(frame:CGRect(x: 0, y: 50, width: kScreenWidth, height: 130))
        bookTitleView?.delegate = self
        self.view.addSubview(bookTitleView!)
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 200, width: kScreenWidth, height: kScreenHeight - 200), style:.Grouped)
        //可以去掉 tableView 下面多余 的线
        self.tableView?.tableFooterView = UIView()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "PushNewCell")
        self.tableView?.backgroundColor = UIColor(colorLiteralRed: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
        self.view.addSubview(self.tableView!)
        
        self.titleArray = ["标题", "评分", "分类", "书评"]
        
        ratingView = RatingView(frame: CGRect(x: 10, y: 10, width: kScreenWidth - 20, height: 24))
        ratingView?.rating = 0
    }
    
    func colse(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    func sure(){
        
       print("sure")
    }
    func bookCoverClick() {
        
        if #available(iOS 8.0, *) {
            let vc = PhotoPickerController()
            vc.delegate = self
            self.presentViewController(vc, animated: true, completion: { () -> Void in
            })
        } else {
            
        }
        
    }
    
    //MARK:- tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "PushNewCell")
        //重用
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        //箭头
        if indexPath.row != 1{
            cell.accessoryType = .DisclosureIndicator
        }
        cell.textLabel?.text = titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 18)
        cell.detailTextLabel?.font = UIFont(name: MY_FONT, size: 13)
        
        var row = indexPath.row
        if self.isShowScore && row > 1{
            row--
        }
        switch row{
        
            case 0:
                cell.detailTextLabel?.text = book_title
                break
            case 2:
                cell.detailTextLabel?.text = self.type + "->" + self.detailType
                break
            case 3:
                break
            default:
                break
        }
        if self.isShowScore && indexPath.row == 2{
            cell.selectionStyle = .None
            cell.accessoryType = .None
            cell.contentView.addSubview(ratingView!)
        }
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //点击变暗再恢复 的动画
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        
        var row = indexPath.row
        if isShowScore && row > 1{
        
            row -= 1
        }
        
        switch row{
            
            case 0:
                self.selectTitle()
                break
            case 1:
                self.giveScore()
                break
            case 2:
                self.selectType()
                break
            case 3:
                self.giveDescription()
                break
            default:
                break
        }
    }
    //标题
    func selectTitle(){
        
        let vc = Push_BookTitleController()
        vc.callBack = ({
            (title:String) -> Void in
            
            self.book_title = title
            self.tableView?.reloadData()
        })
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }

    }
    //评分
    func giveScore(){
        
        //插入 cell
        self.tableView?.beginUpdates()
        
        if isShowScore {
            let tempIndexpath = [NSIndexPath(forRow: 2, inSection: 0)]
            self.titleArray.removeAtIndex(2)
            self.tableView?.deleteRowsAtIndexPaths(tempIndexpath, withRowAnimation: .Right)
            self.isShowScore = false
        
        }else{
            let tempIndexpath = [NSIndexPath(forRow: 2, inSection: 0)]
            self.titleArray.insert("", atIndex: 2)
            self.tableView?.insertRowsAtIndexPaths(tempIndexpath, withRowAnimation: .Left)
            self.isShowScore = true
        
        }
        
        self.tableView?.endUpdates()
    }
    //分类
    func selectType(){
        
        let vc = Push_TypeController()
        vc.type = self.type
        vc.detailType = self.type
        vc.callBack = ({
            (type:String,detailType:String)->Void in
            self.type = type
            self.detailType = detailType
            self.tableView?.reloadData()
        })
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
    
    }
    //书评
    func giveDescription(){
    
    }
    

    //MARK:- BookCoverDelegate
    //选取图片
    func getImageFromPicker(image: UIImage) {
        
        //去裁剪
        let croperVC = VPImageCropperViewController(image: image, cropFrame: CGRect(x: 0, y: 100, width: kScreenWidth, height: kScreenWidth * 120/80), limitScaleRatio: 3)
        croperVC.delegate = self
        self.presentViewController(croperVC, animated: true) { () -> Void in
            
            
        }
        
    }
    //MARK:- PhotoPickerDelegate
    //裁剪成功
    func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        
        self.bookTitleView?.bookCover?.setImage(editedImage, forState: .Normal)
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
        }

    }
    //取消裁剪
    func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
