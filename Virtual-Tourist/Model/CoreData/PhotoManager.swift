//
//  PhotoManager.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 22/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation

/*
 this class is used to Manage changes (addition,deletion, etc...) in Core Data for Photo DataModel
 */

class PhotoManager {
    
    class func getNewPhoto(pin: Pin, imageUrl: String) {
        
        let photo = Photo(context: DataController.shared.viewContext)
        photo.createdAt = Date()
        photo.imageURL = imageUrl
        photo.pin = pin
    }
    
    class func savePhotos(pin: Pin, images: [FlickerImage]) {
        
        for image in images {
            getNewPhoto(pin: pin, imageUrl: image.urlM)
        }
        DataController.shared.saveContext()
    }
    
    class func deletePhotos(photos: [Photo]) {
        for photo in photos {
            deletePhoto(photo: photo)
        }
        DataController.shared.saveContext()
    }
    
    class func deletePhoto(photo: Photo) {
        DataController.shared.viewContext.delete(photo)
    }
    
    
    
}

