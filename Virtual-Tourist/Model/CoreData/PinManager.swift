//
//  PinManager.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 21/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation

/*
 this class is used to Manage changes (addition,deletion, etc...) in Core Data for Pin DataModel
 */

class PinManager {
    
    class func getNewPin(latitude: Double, longitude: Double) -> Pin {
        
        let pin = Pin(context: DataController.shared.viewContext)
        pin.createdAt = Date()
        pin.latitude = latitude
        pin.longitude = longitude
        DataController.shared.saveContext()
        return pin
    }
}
