//
//  detailViewController.swift
//  json
//
//  Created by ChouBingNan on 2018/8/23.
//  Copyright © 2018年 ChouBingNan. All rights reserved.
//

import UIKit
var detail = UIPasteboard.general.string
struct file: Decodable {
    let msg: String
    let code: String
    let invNum: String
    let invoiceTime: String
    let sellerBan: String
    let buyerBan: String
    let invStatus: String
    let sellerName: String
    let invPeriod: String
    let sellerAddress: String
    let invDate: String
}


class detailViewController: UIViewController {
    // Parsing Json pass from Pasteboard

    @IBAction func onPostTapped(_ sender: Any) {
        //parsing
        func convertToDictionary(text: String) -> [String: Any]? {
            if let data = text.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch {
                    print(error.localizedDescription)
                }
            }
            return nil
        }
        
        let str = detail
        
        let dict = convertToDictionary(text: str!)
        //let aaa = dict?.description
        //print(dict!["invNum"])
        //print(dict!["invPeriod"])
        
        let parameters = ["{ \"phoneNo\": \"0912345678\", \"invNum\": \"\(dict!["invNum"])\", \"invPeriod\": \"\(dict!["invPeriod"])\", \"invoiceTime\": \"\(dict!["invoiceTime"])\", \"invDonatable\": \(dict!["invDonatable"]), \"sellerBan\": \"\(dict!["sellerBan"])\", \"sellerName\": \"\(dict!["sellerName"])\", \"sellerAddress\": \"\(dict!["sellerAddress"])\"}" ]
        
        guard let url = URL(string: "https://virtserver.swaggerhub.com/bluefet/inv-qrcode/1/insCarrierInv") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared

        
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            let alert = UIAlertController(title: "Alert", message: "儲存成功!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "關閉此通知", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "再掃一張", style: .default, handler:{ ACTION in
                self.performSegue(withIdentifier: "backcamera", sender: nil) //trigger "儲存發票" button and navigate to next page
            }))
            alert.addAction(UIAlertAction(title: "結束", style: .default, handler:{ ACTION in
                self.performSegue(withIdentifier: "backhome", sender: nil) //trigger "儲存發票" button and navigate to next page
            }))
            self.present(alert, animated: true, completion: nil)
            }.resume()

    }
    
    @IBOutlet weak var content: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        content.text = detail
        content.numberOfLines = 0
}
}



