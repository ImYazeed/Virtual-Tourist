//
//  FlickerResponse.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 21/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation

// MARK: - FlickerResponse
struct FlickerResponse: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [FlickerImage]
}

// MARK: - Photo
struct FlickerImage: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let urlM: String
    let heightM, widthM: String
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
        case urlM = "url_m"
        case heightM = "height_m"
        case widthM = "width_m"
    }
}
