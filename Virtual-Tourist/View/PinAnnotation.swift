//
//  PinAnnotation.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 21/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation
import MapKit

class PinAnnotation: MKPointAnnotation{
    
    var pinObject: Pin!
    
    init(pin: Pin){
        super.init()
        self.pinObject = pin
        coordinate.latitude = pin.latitude
        coordinate.longitude = pin.longitude
    }
    
    override init() {
        super.init()
    }
}

