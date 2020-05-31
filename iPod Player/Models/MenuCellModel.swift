//
//  MenuCellModel.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import UIKit

struct MenuCellModel {
    let title: String
    let image: UIImage
    
    init(title: String, image: String = "doc") {
        self.title = title
        self.image = UIImage(systemName: image)!
    }
}
