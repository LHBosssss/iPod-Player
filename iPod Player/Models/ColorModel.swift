//
//  ColorModel.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/28/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import UIKit

struct ColorModel {
    let bgColor: UIColor
    let controlColor: UIColor
    let buttonColor: UIColor
    let borderColor: UIColor

    init(bg: UIColor, ct: UIColor, bt: UIColor, bd: UIColor) {
        self.bgColor = bg
        self.controlColor = ct
        self.buttonColor = bt
        self.borderColor = bd
    }
}
