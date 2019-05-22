//
//  Constants.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 20/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation

struct FlickrAPI {
    static let apiKey = "9b5e37e57bc29dd485a87d2e3cf3266c"
    static let baseURL = "https://api.flickr.com/services/rest/?method="
    
    struct Parameters {
        static let apiKeyVar = "&api_key="
        static let latitude = "&lat="
        static let longitude = "&lon="
        static let extras = "&extras=url_m"
        static let perPage = "&per_page="
        static let page = "&page="
        static let format = "&format=json"
        static let callBack = "&nojsoncallback=1"
        static let radious = "&radius=20"
    }
    
    enum EndPoints {
        
        case searchPhoto(latitude: Double, longitude: Double, page: Int, perPage: Int)
        
        
        var stringValue: String {
            switch self {
            case let .searchPhoto(latitude, longitude, page, perPage) :
                return "\(FlickrAPI.baseURL)flickr.photos.search\(Parameters.apiKeyVar)\(FlickrAPI.apiKey)\(Parameters.latitude)\(latitude)\(Parameters.longitude)\(longitude)\(Parameters.extras)\(Parameters.perPage)\(perPage)\(Parameters.radious)\(Parameters.page)\(page)\(Parameters.format)\(Parameters.callBack)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
    
}


