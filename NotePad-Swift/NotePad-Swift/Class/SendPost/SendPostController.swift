//
//  SendPostController.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/6.
//  Copyright © 2016年 Silver. All rights reserved.
//

/*

UIImageView

相册访问


*/

import UIKit

class SendPostController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var textView:UITextView?
    var imageView:UIImageView?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor.purpleColor()

        creatViews()
    }
    func creatViews(){
        
        Common.addNavLeftBtn(self, btnTitle: "取消")
        Common.addNavRightBtn(self, btnTitle: "发帖")
    
        self.textView = UITextView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        self.textView?.backgroundColor = UIColor.whiteColor()
        self.textView?.delegate = self
        self.textView?.text = "请不要少于1个字"
        self.view.addSubview(self.textView!)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        imageView!.image = UIImage(named: "douban.png")
        imageView!.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "selectImage:")
        imageView!.addGestureRecognizer(tap)
        self.view.addSubview(imageView!)
    
    }
    func goBack(){
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    func makeSure(){
        
        let post = AVObject(className: "Post")

        let img = self.imageView?.image
        let tempImg = UIImage(named: "douban.png")
        if (img?.isEqual(tempImg) == true){

//            let imageFile = AVFile(name: "image.png", data: nil)
//            imageFile.save()
//            post.setObject(imageFile, forKey: "image")
        }else{
            let imageData = UIImagePNGRepresentation(img!)
            let imageFile = AVFile(name: "image.png", data: imageData)
            imageFile.save()
            post.setObject(imageFile, forKey: "image")

        }
        post.setObject(self.textView!.text, forKey: "content")
        post.setObject(AVUser.currentUser(), forKey: "user")
        post.setObject(AVUser.currentUser().username, forKey: "uname")

        
        post.saveInBackgroundWithBlock { (succeeded:Bool, error:NSError!) -> Void in
            if succeeded{
                // post 保存成功
                ProgressHUD.showSuccess("发帖成功")

            }else{
                // 保存 post 时出错
                print(error)
            }
        }
        
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    func selectImage(tap:UITapGestureRecognizer){
//        print("tap=====")
        
        let pick:UIImagePickerController = UIImagePickerController()
        pick.delegate = self
        self.presentViewController(pick, animated: true, completion: nil)
        
        
    }
    func textViewShouldBeginEditing(textView: UITextView) -> Bool{
    
        textView.text = ""
        return true
    }
    
    /**
     实现代理方法 UIImagePickerControllerDelegate,UINavigationControllerDelegate
     
     */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        

        let gotImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView!.image = gotImage
//        print(info);

        self.dismissViewControllerAnimated(true, completion: nil);
        
    }
    
    /**
     实现代理方法 UIImagePickerControllerDelegate,UINavigationControllerDelegate
     
     */
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil);
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
