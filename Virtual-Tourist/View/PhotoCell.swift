//
//  PhotoCell.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 22/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import Kingfisher


class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var flickrImage: UIImageView!
    
    var photo: Photo! {
        didSet {
            if let image = photo.fetchImage() {
                flickrImage.image = image
            } else if let url = URL(string: photo.imageURL!){
                flickrImage.kf.indicatorType = .activity
                flickrImage.kf.setImage(with: url, options: [.transition(.fade(0.5))])
            }
        }
    }
}

extension Photo {
    
    func fetchImage() -> UIImage? {
        guard let data = image else { return nil }
        return UIImage(data: data)
    }
}
