//
//  detailViewController.swift
//  json
//
//  Created by ChouBingNan on 2018/8/23.
//  Copyright © 2018年 ChouBingNan. All rights reserved.
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

