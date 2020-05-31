//
//  PlaylistModel.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/27/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import UIKit

struct PlaylistModel {
    let title: String
    let image: UIImage
    let songs: Int
    
    init(title: String, image: UIImage = UIImage(systemName: "music.note.list")!, songs: Int) {
        self.title = title
        self.image = image
        self.songs = songs
    }
}
