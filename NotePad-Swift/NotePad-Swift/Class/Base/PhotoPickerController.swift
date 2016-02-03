//
//  PhotoPickerController.swift
//  NotePad-Swift
//
//  Created by 王立震 on 16/2/3.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

protocol PhotoPickerDelegate{

    func getImageFromPicker(image:UIImage)
}

@available(iOS 8.0, *)
class PhotoPickerController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var alert:UIAlertController?
    var picker:UIImagePickerController?
    
    var delegate:PhotoPickerDelegate?


    init() {
        super.init(nibName: nil, bundle: nil)
        //此 控制器 透明
        self.modalPresentationStyle = .OverFullScreen
        self.view.backgroundColor = UIColor.clearColor()
        
        self.picker = UIImagePickerController()
        self.picker?.allowsEditing = false //不允许截图
        self.picker?.delegate = self
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(animated: Bool) {
        
        if self.alert == nil{
        
            self.alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            self.alert?.addAction(UIAlertAction(title: "从相册中选择", style: .Default, handler: { (action) -> Void in
                self.openPhotoAlbum()
            }))
            self.alert?.addAction(UIAlertAction(title: "打开相机", style: .Default, handler: { (action) -> Void in
                self.takePhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            }))
            
            self.presentViewController(self.alert!, animated: true, completion: { () -> Void in
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //打开相机 照相
    func takePhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            self.picker?.sourceType = .Camera
            self.presentViewController(self.picker!, animated: true, completion: { () -> Void in
                
            })
        
        }else{
            
            let alertView = UIAlertController(title: "此机型无相机", message: nil, preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
                
            }))
            self.presentViewController(alertView, animated: true, completion: { () -> Void in
        
            })
        
        }
    
    }
    //打开相册
    func openPhotoAlbum(){
        self.presentViewController(self.picker!, animated: true, completion: { () -> Void in
            
        })
    }
    //取消 选择图片
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.picker?.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
            })
        })
    }
    //选择照片
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.picker?.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
              
                self.delegate?.getImageFromPicker(image)
            })
        })
    }
    


}
