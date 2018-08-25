//
//  ViewController.swift
//  QRReader
//
//  Created by Sebastian Hette on 17.07.2017.
//  Copyright © 2017 MAGNUMIUM. All rights reserved.
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

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var square: UIImageView!
    var video = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Api

        
        // Do any additional setup after loading the view, typically from a nib.
        
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
                    let s = object.stringValue
                    //let i = s?.index((s?.startIndex)!, offsetBy: 15)
                    let slice = s?.prefix(15)
                    let myString = String(slice!)
                    //Api
                    let jsonUrlStringheader = "https://us-central1-bluefet-einvoice-poc-214217.cloudfunctions.net/qrcode-fake/"
                    let jsonUrlString = jsonUrlStringheader + myString
                    guard let url = URL(string: jsonUrlString) else { return }
                    
                    URLSession.shared.dataTask(with: url) { (data, response, err) in
                        //perhaps check err
                        //also perhaps check response status 200 OK
                        
                        guard let data = data else { return }
                        
                        let dataAsString = String(data: data, encoding: .utf8)
                        print(dataAsString)
                        let dataString = String(dataAsString!)
                        //self.content.text = dataString
                        let alert = UIAlertController(title: "QR Code", message: dataString, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                        alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                            UIPasteboard.general.string = object.stringValue
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        }.resume()
                    //Alert
                }
            }
        }
    }
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //var detailController = segue.destination as! detailViewController
        //detailController.dataString = dataAsString
    //}
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

