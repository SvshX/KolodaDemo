//
//  KolodaPhotoView.swift
//  KolodaDemo
//
//  Created by Sascha Melcher on 24/03/2016.
//  Copyright © 2016 Locals Labs. All rights reserved.
//
import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {[unowned self] response, data, error in
                if let data = data {
                    self.image = UIImage(data: data)
                }
                })
        }
    }
}

class KolodaPhotoView: UIView {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    weak var kolodaPhotoViewDelegate: KolodaPhotoViewDelegate?
    var viewController = ViewController()
   
    
    @IBAction func previousButton(sender: AnyObject) {
        
        kolodaPhotoViewDelegate = viewController
        
        if (kolodaPhotoViewDelegate != nil) {
            kolodaPhotoViewDelegate?.previousButtonTapped()
        }
        else {
            print("You forgot to set your reference in customTipDelegate to contain an instance of SwipeTipViewController!")
        }
        
    }
    
    
    
}

protocol KolodaPhotoViewDelegate:class {
    
    func previousButtonTapped()
    
}