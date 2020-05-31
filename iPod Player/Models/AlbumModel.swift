//
//  AlbumModel.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import UIKit

struct AlbumModel {
    let title: String
    let image: UIImage
    let artist: String
    let count: Int
    
    init(title: String, image: UIImage, artist: String, count: Int) {
        self.title = title
        self.image = image
        self.artist = artist
        self.count = count
    }
}
