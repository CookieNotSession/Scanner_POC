//
//  drinkViewController.swift
//  drinkchoose
//
//  Created by yaya on 2016/11/24.
//  Copyright © 2016年 yaya. All rights reserved.
//

import UIKit

class drinkViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        let button = sender as! UIButton
        let controller = segue.destination as!
        ViewController
        controller.name = button.currentTitle //把按鈕上的名字傳過去
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
