//
//  ViewController.swift
//  create_bar_code
//
//  Created by ryota on 2020/06/03.
//  Copyright © 2020 ryota. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.image =  self.generateCode128Barcode(string: UIDevice.current.identifierForVendor!.uuidString)
        print(UIDevice.current.identifierForVendor!.uuidString)

    }

    func generateCode128Barcode(string: String) -> UIImage? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }
        
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        
        filter.setDefaults()
        filter.setValue(data, forKey: "inputMessage")
        
        guard let output = filter.outputImage else {
            return nil
        }
        
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(output, from: output.extent) else {
            return nil
        }
        
        let image = UIImage(cgImage: cgImage, scale: 2.0, orientation: UIImage.Orientation.up)
        
        return image
    }
}


