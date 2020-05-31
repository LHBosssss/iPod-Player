//
//  ArtistModel.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/27/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

struct ArtistModel {
    let title: String
    let image: UIImage
    let albums: Int
    let songs: Int
    let albumCollection: [MPMediaItemCollection]
    init(title: String, image: UIImage, albums: Int, songs: Int, collection: [MPMediaItemCollection]) {
        self.title = title
        self.image = image
        self.albums = albums
        self.songs = songs
        self.albumCollection = collection
    }
}
