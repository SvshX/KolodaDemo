//
//  ViewController.swift
//  KolodaDemo
//
//  Created by Sascha Melcher on 24/03/2016.
//  Copyright © 2016 Locals Labs. All rights reserved.
//

import UIKit
import Koloda
import pop
import Alamofire

private let frameAnimationSpringBounciness:CGFloat = 9
private let frameAnimationSpringSpeed:CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent:CGFloat = 0.1


class KolodaPhoto {
    var photoUrlString = ""
    var title = ""
    
    init () {
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        
        title = (dictionary["title"] as? String)!
        photoUrlString = (dictionary["url"] as? String)!
    }
}

class ViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate, KolodaPhotoViewDelegate {

    
    @IBOutlet weak var kolodaView: CustomKolodaView!
    var photos = Array<KolodaPhoto>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        fetchPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func previousButtonTapped() {
        
        print("Previous button tapped!")
        self.kolodaView.revertAction()
        
    }

    //MARK: Datahandling
    func fetchPhotos() {
        Alamofire.request(.GET, "http://jsonplaceholder.typicode.com/photos")
            .responseJSON { response -> Void in
                if let photosArray = response.result.value as? NSArray {
                    photosArray.enumerateObjectsUsingBlock({ (photo, index, stop) -> Void in
                        if index == 15 {
                            let shouldStop: ObjCBool = true
                            stop.initialize(shouldStop)
                        }
                        if let photoDictionary = photo as?  Dictionary<String, AnyObject> {
                            self.photos.append(KolodaPhoto(photoDictionary))
                        }
                    })
                    self.kolodaView.reloadData()
                }
        }
    }
    
    //MARK: KolodaViewDataSource
    func koloda(kolodaNumberOfCards koloda:KolodaView) -> UInt {
        return UInt(self.photos.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let photoView = NSBundle.mainBundle().loadNibNamed("KolodaPhotoView",
            owner: self, options: nil)[0] as? KolodaPhotoView
        let photo = photos[Int(index)]
        photoView?.photoImageView?.imageFromUrl(photo.photoUrlString)
   //     photoView?.photoTitleLabel?.text = photo.title
        return photoView!
    }
//    func kolodaViewForCardOverlayAtIndex(koloda: KolodaView, index: UInt) -> OverlayView? {
//        return NSBundle.mainBundle().loadNibNamed("CustomOverlayView",
//            owner: self, options: nil)[0] as? OverlayView
//    }
    
    //MARK: KolodaViewDelegate
    
    func kolodaDidSwipedCardAtIndex(koloda: KolodaView, index: UInt, direction: SwipeResultDirection) {
    }
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        //Example: reloading
        fetchPhotos()
    }
    
    func kolodaDidSelectCardAtIndex(koloda: KolodaView, index: UInt) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
    
    func kolodaShouldApplyAppearAnimation(koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaBackgroundCardAnimation(koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation.springBounciness = frameAnimationSpringBounciness
        animation.springSpeed = frameAnimationSpringSpeed
        return animation
    }
    
}

