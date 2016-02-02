//
//  DoubanViewController.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/4.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*

cell标题 子标题
图片缓存
默认 图片

进度条
定时器
音乐播放

*/

import UIKit
import MediaPlayer
import QuartzCore

let 频道列表 = "http://www.douban.com/j/app/radio/channels"
let 歌曲列表 = "http://douban.fm/j/mine/playlist?channel=0"

class DoubanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HttpProtocolDelegate, ChannelDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet var tap: UITapGestureRecognizer!
    @IBOutlet weak var playImage: UIImageView!
    
    var httpCol:HttpController = HttpController()
    var 歌曲数组:NSArray = NSArray()
    var 频道数组:NSArray = NSArray()
    //缓存图片
    var imageCache = Dictionary<String,UIImage>()
    //播放器
    var audioPlayer = MPMoviePlayerController()
    
    var timer:NSTimer?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        httpCol.delegate = self
        httpCol.onSearch(频道列表)
        httpCol.onSearch(歌曲列表)
        
        progress.progress = 0.0
        
        imageView.addGestureRecognizer(tap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 歌曲数组.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "douban")
        
        let rowDic :NSDictionary = 歌曲数组[indexPath.row] as! NSDictionary
        cell.textLabel?.text = rowDic["title"] as? String
        //子标题
        cell.detailTextLabel?.text = rowDic["artist"] as? String
        //默认 图片
        cell.imageView?.image = UIImage(named: "douban.png")
        //网络图片
        let url:String = (rowDic["picture"] as? String)!
//        let image:UIImage = self.imageCache[url]! as UIImage
//
//        if image.isEqual(nil){
//             //为空
            let imgUrl = NSURL(string:(url))
            let request = NSURLRequest(URL: imgUrl!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
                
                let img = UIImage(data: data!)
                //加入缓存字典
                self.imageCache[url] = img!
                //MARK:－不知到为啥错的
//                cell.imageView?.image = img
                
            })
        
//        }else{
//            //不为空，直接赋值
//            cell.imageView?.image = image
//        }
    
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //点击播放
        let rowDic = 歌曲数组[indexPath.row] as! NSDictionary
        let audioUrl = rowDic["url"] as! String
        onSetAudio(audioUrl)
        let imgUrl = rowDic["picture"] as! String
        onSetImage(imgUrl)
        
    }
    //cell显示动画
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25) { () -> Void in
            
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    //MARK:push 正向传值
    @IBAction func pushToNext(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Douban", bundle: NSBundle.mainBundle())
        let channelVC:ChannelViewController = storyboard.instantiateViewControllerWithIdentifier("ChannelViewController") as! ChannelViewController
        channelVC.channelData = 频道数组
        channelVC.delegate = self
        self.navigationController?.pushViewController(channelVC, animated: true)
        
    }
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        
        if sender.view == playImage{
        
            //暂停状态
            playImage.hidden = true
            audioPlayer.play()
            playImage.removeGestureRecognizer(tap)
            imageView.addGestureRecognizer(tap)
            
            
        }else if sender.view == imageView{
            
            //播放状态状态
            playImage.hidden = false
            audioPlayer.pause()
            playImage.addGestureRecognizer(tap)
            imageView.removeGestureRecognizer(tap)
        
        }
    }
    //MARK:请求成功
    func didReceiveResults(results:NSDictionary){
    
        if (results["song"] != nil){
            
            歌曲数组 = results["song"] as! NSArray
            self.tableView.reloadData()
            
//            print(歌曲数组)
            
            //默认播放第一首
            let firstDic = 歌曲数组[0] as! NSDictionary
            let audioUrl = firstDic["url"] as! String
            onSetAudio(audioUrl)
            let imgUrl = firstDic["picture"] as! String
            onSetImage(imgUrl)
        
        } else if (results["channels"] != nil) {
            频道数组 = results["channels"] as! NSArray
        }
    }
    //MARK:反向传值
    func onChangeChannel(channel_id:String){
    
        //再次请求数据
        let url = "http://douban.fm/j/mine/playlist?\(channel_id)"
        httpCol.onSearch(url)
    }
    //MARK:播放
    func onSetAudio(url:String){
        
        timer?.invalidate()
        self.timeLabel.text = "00:00"
        
        self.audioPlayer.stop()
        self.audioPlayer.contentURL = NSURL(string: url)
        self.audioPlayer.play()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "onUpDate", userInfo: nil, repeats: true)
        
        //暂停状态 切歌
        playImage.removeGestureRecognizer(tap)
        imageView.addGestureRecognizer(tap)
        playImage.hidden = true
        
    }
    func onSetImage(url:String){
        
        //网络图片
        //        let image:UIImage = self.imageCache[url]! as UIImage
        //
        //        if image.isEqual(nil){
        //             //为空
        let imgUrl = NSURL(string:(url))
        let request = NSURLRequest(URL: imgUrl!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
            
            let img = UIImage(data: data!)
            //加入缓存字典
            self.imageCache[url] = img!
//            self.imageView.image = img
            
        })
        
        //        }else{
        //            //不为空，直接赋值
        //self.imageView.image = img

        //        }
        
    }
    //更新时间
    func onUpDate(){
        let c = audioPlayer.currentPlaybackTime
        if c > 0.0{
            let t = audioPlayer.duration
            let p = Float(c/t)
            progress.setProgress(p, animated: true)
            
            let all = Int(c)
            let m = all % 60
            let f = Int(all/60)
            
            var time:String = ""
            
            
            if f < 10{
                time = "0\(f):"
            
            }else{
                time = "\(f):"

            }
            
            if m < 10{
                time += "0\(m)"

            }else{
                time += "\(m)"
                
            }
            
            timeLabel.text = time
        }
    }
    
    //storyboard 跳转的时候 传输数据
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        let channelVC = segue.destinationViewController as! ChannelViewController
    //        channelVC.channelData = 频道数组
    //    }

}
