//
//  detailViewController.swift
//  drinkchoose
//
//  Created by yaya on 2016/11/24.
//  Copyright © 2016年 yaya. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    @IBOutlet weak var namelabel: UILabel! //飲料店名
    @IBOutlet weak var bgImageview: UIImageView! //背景圖
    @IBOutlet weak var signaturelabel: UILabel! //招牌飲品
    
    var name: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if name == "茶湯會" {
            bgImageview.image = UIImage(named: "bg1")
            signaturelabel.text = "芋香翡翠拿鐵"

        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}
