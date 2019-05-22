//
//  FlickrClient.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 22/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation


class FlickrClient {
    
    class func fetchPhotos(latitude: Double, longitude: Double, sucssess: @escaping ([FlickerImage]) -> Void, failure: @escaping (Error) -> Void) {
        
        // get Random page between 1...100
        let page = Int.random(in: 1...100)
        
        let url = FlickrAPI.EndPoints.searchPhoto(latitude: latitude, longitude: longitude, page: page, perPage: 9).url
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    failure(error!)
                }
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let flickerResponse = try decoder.decode(FlickerResponse.self, from: data)
                DispatchQueue.main.async {
                    sucssess(flickerResponse.photos.photo)
                }
            } catch {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }
        
        task.resume()
    }
}
