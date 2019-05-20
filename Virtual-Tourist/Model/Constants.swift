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
    
    struct URLkeys {
        static let apiKeyVar = "&api_key="
        static let latitude = "&lat="
        static let longitude = "&lon="
        static let extras = "&extras=url_m"
        static let perPage = "&per_page="
        static let page = "&page="
        static let format = "&format=json"
        static let callBack = "&nojsoncallback=1"
    }
    
    enum EndPoints {
        
        case searchPhoto(latitude: Double, longitude: Double, page: Int, perPage: Int)
        
        
        var stringValue: String {
            switch self {
            case let .searchPhoto(latitude: latitude, longitude: longitude, page: page, perPage: perPage) :
                return "\(FlickrAPI.baseURL)flickr.photos.search\(URLkeys.apiKeyVar)\(FlickrAPI.apiKey)\(URLkeys.latitude)\(latitude)\(URLkeys.longitude)\(longitude)\(URLkeys.extras)\(URLkeys.perPage)\(perPage)\(URLkeys.page)\(page)\(URLkeys.format)\(URLkeys.callBack)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
        
    }
    
}


