//
//  ViewController.swift
//  json
//
//  Created by ChouBingNan on 2018/8/23.
//  Copyright © 2018 ChouBingNan. All rights reserved.
//

import UIKit
import AVFoundation

struct website: Decodable {
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

// structure for json

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var name: String!

    @IBOutlet weak var square: UIImageView!
    var video = AVCaptureVideoPreviewLayer()
    var globalvar = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Creating session
        let session = AVCaptureSession()
        
        //Define capture devcie
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }
        catch
        {
            print ("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        self.view.bringSubview(toFront: square)
        
        session.startRunning()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects != nil && metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObjectTypeQRCode
                {
                    let s = object.stringValue  //get camera information and pass to string s
                    let slice = s?.prefix(15)  //slice pre 15 number for invoice to call the api
                    let myString = String(slice!) // because alert message can't put the "SubString" type , so type casting to String Type
                    
                    //Start to call Api
                    let jsonUrlStringheader = "https://us-central1-bluefet-einvoice-poc-214217.cloudfunctions.net/qrcode-fake/"
                    let jsonUrlString = jsonUrlStringheader + myString // Concatenate url and myString we scan
                    guard let url = URL(string: jsonUrlString) else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, err) in
                        
                        guard let data = data else { return }
                        
                        let dataAsString = String(data: data, encoding: .utf8)
                        //print(dataAsString)
                        let dataString = String(dataAsString!)
                        
                        // Scan success and pop up alert
                        let alert = UIAlertController(title: "QR Code", message: dataString, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "再拍一次", style: .default, handler: nil))
                        alert.addAction(UIAlertAction(title: "儲存發票", style: .default, handler:{ ACTION in
                            UIPasteboard.general.string = dataAsString // pass the dataAsString to Pasteboard
                            self.performSegue(withIdentifier: "godetail", sender: nil) //trigger "儲存發票" button and navigate to next page
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        }.resume()
                    //Alert
                }
            }
        }
    }


    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

