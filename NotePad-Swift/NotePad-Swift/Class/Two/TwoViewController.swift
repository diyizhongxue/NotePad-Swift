
//  Created by Silver on 15/12/27.
//  Copyright © 2015年 Silver. All rights reserved.
//

/*

*/

import UIKit

class TwoViewController: UIViewController{
    

    override func viewDidLoad() {
        
        self.edgesForExtendedLayout = .None
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        self.title = "杂乱"
        
        creatViews()
    }
    func creatViews(){

    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
