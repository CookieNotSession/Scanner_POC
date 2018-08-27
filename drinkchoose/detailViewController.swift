//
//  detailViewController.swift
//  drinkchoose
//
//  Created by yaya on 2016/11/24.
//  Copyright © 2016年 yaya. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet weak var content: UILabel!
    var detail = UIPasteboard.general.string
    override func viewDidLoad() {
        super.viewDidLoad()
        content.text = detail
        content.numberOfLines = 0
}
}

