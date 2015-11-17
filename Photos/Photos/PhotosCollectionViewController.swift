//
//  PhotosViewController.swift
//  Photos
//
//  Created by jnvb on 2015. 11. 16..
//  Copyright © 2015년 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos: [Photo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("loaded!!")

        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
        photos = []
    }
    
    override func viewDidAppear(animated: Bool) {
        //print("loaded!!")
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        let imageView = UIImageView(frame:CGRectMake(0, 0, 100, 100));
        let currentPhoto = photos[indexPath.item]
        
        loadImageForCell(currentPhoto, imageView: imageView)
        cell.addSubview(imageView)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void))
    {
        NSURLSession.sharedSession().dataTaskWithURL(url)
        {
            (data, response, error) in completion(data: data, response: response, error: error)
        }.resume()
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        performSegueWithIdentifier("photoDetailSegue", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let indexPath = sender as! NSIndexPath
        let photoIndex = indexPath.row
        
        if (segue.identifier == "photoDetailSegue")
        {
            let destinationViewController = segue.destinationViewController as! PhotosViewController
            destinationViewController.photo = photos[photoIndex]
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: 75, height: 75)
    }
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView)
    {
        let url = NSURL(string: photo.url)
        
        if let data = NSData(contentsOfURL: url!)
        {
            imageView.image = UIImage(data: data)
        }
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo])
    {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
}

