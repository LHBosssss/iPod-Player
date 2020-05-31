//
//  ColorModel.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/28/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import UIKit

struct ThemeModel {
    let bgColor: UIColor
    let controlColor: UIColor
    let buttonColor: UIColor
    let borderColor: UIColor
    init(bg: UIColor, bd: UIColor, ct: UIColor, bt: UIColor) {
        self.bgColor = bg
        self.borderColor = bd
        self.controlColor = ct
        self.buttonColor = bt
    }
    
    init(bg: String, bd: String, ct: String, bt: String) {
        self.bgColor = UIColor(hex: "#" + bg)!
        self.borderColor = UIColor(hex: "#" + bd)!
        self.controlColor = UIColor(hex: "#" + ct)!
        self.buttonColor = UIColor(hex: "#" + bt)!
    }
}

struct ThemeModeModel {
    let bgColor: UIColor
    let textColor: UIColor
    init(bg: UIColor, tx: UIColor) {
        self.bgColor = bg
        self.textColor = tx
    }
}
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b: CGFloat
        print(hex)
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            print(hexColor)
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }

        return nil
    }
}
