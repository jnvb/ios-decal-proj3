//
//  PhotosViewController.swift
//  Photos
//
//  Created by jnvb on 2015. 11. 16..
//  Copyright © 2015년 iOS DeCal. All rights reserved.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController {
    
    var photo:Photo?
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var imageHD: UIImageView!
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var heartBtn: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heartBtn.addTarget(self, action: "heartBtnPress", forControlEvents: .TouchUpInside)
        
        //print(photo?.urlHD)
        //print(photo?.username)
        //print(photo?.likes)
        //print(heartBtn.titleLabel!.text)
        
        userNameLabel.text = "By " + (photo?.username!)!
        likeCount.text = photo?.likes
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let DateInFormat:String = dateFormatter.stringFromDate((photo?.date)!)

        dateLabel.text = DateInFormat
        
        let url = NSURL(string: (photo?.urlHD)!)
        
        if let data = NSData(contentsOfURL: url!)
        {
            imageHD.image = UIImage(data: data)
        }
    }
    
    func heartBtnPress()
    {
        if(heartBtn.titleLabel!.text == "♡")
        {
            heartBtn.setTitle("♥️", forState: UIControlState.Normal)
            var count = Int((photo?.likes)!)
            count = count! + 1
            photo?.likes = String(count!)
            likeCount.text = String(count!)
        }
        else
        {
            heartBtn.setTitle("♡", forState: UIControlState.Normal)
            var count = Int((photo?.likes)!)
            count = count! - 1
            photo?.likes = String(count!)
            likeCount.text = String(count!)
        }
    }
}