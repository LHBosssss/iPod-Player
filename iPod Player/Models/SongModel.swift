//
//  SongModel.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import UIKit

struct SongModel {
    let id: String
    let title: String
    let singer: String
    let image: UIImage
    
    init(id: String, title: String, singer: String, image: UIImage) {
        self.id = id
        self.title = title
        self.singer = singer
        self.image = image
    }
}
