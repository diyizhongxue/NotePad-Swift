//
//  OneCell.swift
//  NotePad-Swift
//
//  Created by Silver on 16/1/8.
//  Copyright © 2016年 Silver. All rights reserved.
//

import UIKit

class OneCell: UITableViewCell {
    
    var icon : UIImageView?
    var nameLabel : UILabel?
    var creatTimtLabel : UILabel?
    var contentLabel : UILabel?
    var imgView : UIImageView?
    var view : UIView?

    
    
    var model :OneModel = OneModel(){
        didSet{
        
            if !model.name.isEmpty{
                self.nameLabel?.text = model.name
            }
            self.creatTimtLabel?.text = model.time
            self.contentLabel?.text = model.content
            self.contentLabel?.numberOfLines = 0
            let size = captureTextSizeWithText(model.content, textWidth: kScreenWidth - 60, font: "15")
            self.contentLabel?.frame.size = size
            
            var imgFrame = self.imgView?.frame
            imgFrame?.origin.y = 75 + size.height - 30
            self.imgView?.frame = imgFrame!
            
            
            if model.isImageExist {
                
                self.imgView?.hidden = false
                self.imgView?.image = model.image
                
                var viewFrame = self.view?.frame
                viewFrame?.origin.y = (self.contentLabel?.frame.origin.y)! + size.height + 5 + kScreenWidth - 190
                self.view?.frame = viewFrame!
                
            }else{
                
                self.imgView?.hidden = true
                
                var viewFrame = self.view?.frame
                viewFrame?.origin.y = (self.contentLabel?.frame.origin.y)! + size.height + 10
                self.view?.frame = viewFrame!
                
            }
        }
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        creatViews()
    }

    
    func creatViews(){
        
        view = UIView(frame: CGRect(x: 0, y: 240, width: kScreenWidth, height: 10))
        view!.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(view!)
        
        self.icon = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height:30))
        self.icon?.backgroundColor = UIColor.redColor()
        self.icon?.image = UIImage(named: "home_tab_icon_4")
        self.addSubview(self.icon!)
        
        self.nameLabel = UILabel(frame: CGRect(x: 40, y: 5, width: 100, height: 30))
        self.nameLabel?.text = "游客用户"
        self.nameLabel?.font = UIFont.systemFontOfSize(12)
        self.addSubview(self.nameLabel!)
        
        self.creatTimtLabel = UILabel(frame: CGRect(x: kScreenWidth - 155, y: 5, width: 150, height: 30))
        self.creatTimtLabel?.font = UIFont.systemFontOfSize(12)
        self.creatTimtLabel?.textAlignment = .Right
        self.addSubview(self.creatTimtLabel!)
        
        self.contentLabel = UILabel(frame: CGRect(x: 40, y: 40, width: kScreenWidth - 50, height: 30))
//        self.contentLabel?.backgroundColor = UIColor.redColor()
        self.contentLabel?.font = UIFont.systemFontOfSize(15)
        self.addSubview(self.contentLabel!)
        
        self.imgView = UIImageView(frame: CGRect(x: 100, y: 75, width: kScreenWidth - 200, height: kScreenWidth - 200))
        self.imgView?.backgroundColor = UIColor.redColor()
        self.addSubview(self.imgView!)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func captureTextSizeWithText(text:NSString, textWidth width:CGFloat, font:String)->CGSize{
        
        let constraint = CGSize(width: width, height: 20000.0)
        let tdic = [font:NSFontAttributeName]
        let rect = text.boundingRectWithSize(constraint, options:NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: tdic, context: nil)

        var size:CGSize
        if rect.size.height < 15{
            size = CGSizeMake(kScreenWidth - 50, rect.size.height)

        }else if rect.size.height > 15 && rect.size.height < 30{
            size = CGSizeMake(kScreenWidth - 50, rect.size.height + 10)

        }else{
            size = CGSizeMake(kScreenWidth - 50, rect.size.height + 20)
        }
        
        if text.isEqualToString(""){
            size = CGSizeZero
        }
        return size
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
