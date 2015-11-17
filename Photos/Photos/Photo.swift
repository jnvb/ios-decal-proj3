//
//  PhotosViewController.swift
//  Photos
//
//  Created by jnvb on 2015. 11. 16..
//  Copyright © 2015년 iOS DeCal. All rights reserved.
//

import Foundation

class Photo {
    /* The number of likes the photo has. */
    var likes : String!
    /* The string of the url to the photo file. */
    var url : String!
    var urlHD : String!
    /* The username of the photographer. */
    var username : String!
    
    var date : NSDate!

    /* Parses a NSDictionary and creates a photo object. */
    init (data: NSDictionary) {
        // FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'
        self.username = (data.valueForKey("user") as! NSDictionary).valueForKey("username") as! String
        self.url = ((data.valueForKey("images") as! NSDictionary).valueForKey("low_resolution") as! NSDictionary).valueForKey("url") as! String
        self.urlHD = ((data.valueForKey("images") as! NSDictionary).valueForKey("standard_resolution") as! NSDictionary).valueForKey("url") as! String
        self.likes = String((data.valueForKey("likes") as! NSDictionary).valueForKey("count") as! Int)
        let time = data.valueForKey("created_time") as! String
        date = NSDate(timeIntervalSince1970: Double(time)!)
    }

}