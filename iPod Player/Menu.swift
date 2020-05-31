//
//  Menu.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/28/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import UIKit

struct Menu {
    static var listMenu: [MenuCellModel] = [
        MenuCellModel(title: "Now Playing", image: "play"),
        MenuCellModel(title: "Songs", image: "music.note"),
        MenuCellModel(title: "Playlists", image: "music.note.list"),
        MenuCellModel(title: "Albums", image: "book"),
        MenuCellModel(title: "Artist", image: "person.2.square.stack"),
        MenuCellModel(title: "Shuffle", image: "shuffle"),
        MenuCellModel(title: "Settings", image: "gear"),
    ]
    
    static var listSettings: [MenuCellModel] = [
        MenuCellModel(title: "Shuffle", image: "shuffle"),
        MenuCellModel(title: "Repeat", image: "repeat"),
        MenuCellModel(title: "Theme", image: "paintbrush"),
    ]
}

struct Theme {
    static var listTheme: [ColorModel] = [
        ColorModel(bg: .black, ct: .black, bt: .white, bd: .lightGray),
        ColorModel(bg: .white, ct: .white, bt: .black, bd: .darkGray),
        ColorModel(bg: UIColor(red: 0.85, green: 0.88, blue: 0.91, alpha: 1.00), ct: UIColor(red: 0.08, green: 0.16, blue: 0.31, alpha: 1.00), bt: UIColor(red: 0.00, green: 0.56, blue: 0.62, alpha: 1.00), bd: UIColor(red: 0.15, green: 0.29, blue: 0.43, alpha: 1.00)),
        ColorModel(bg: UIColor(red: 0.58, green: 0.88, blue: 0.83, alpha: 1.00), ct: UIColor(red: 0.99, green: 0.89, blue: 0.54, alpha: 1.00), bt: UIColor(red: 0.95, green: 0.51, blue: 0.51, alpha: 1.00), bd: UIColor(red: 0.92, green: 1.00, blue: 0.82, alpha: 1.00)),
        ColorModel(bg: UIColor(red: 0.79, green: 0.91, blue: 0.84, alpha: 1.00), ct: UIColor(red: 0.13, green: 0.25, blue: 0.32, alpha: 1.00), bt: UIColor(red: 0.23, green: 0.41, blue: 0.47, alpha: 1.00), bd: UIColor(red: 0.52, green: 0.66, blue: 0.67, alpha: 1.00)),
        ColorModel(bg: UIColor(red: 0.19, green: 0.11, blue: 0.25, alpha: 1.00), ct: UIColor(red: 0.53, green: 0.19, blue: 0.31, alpha: 1.00), bt: UIColor(red: 0.89, green: 0.24, blue: 0.34, alpha: 1.00), bd: UIColor(red: 0.32, green: 0.15, blue: 0.27, alpha: 1.00)),
        ColorModel(bg: UIColor(red: 0.89, green: 0.99, blue: 0.99, alpha: 1.00), ct: UIColor(red: 0.65, green: 0.89, blue: 0.91, alpha: 1.00), bt: UIColor(red: 0.44, green: 0.79, blue: 0.81, alpha: 1.00), bd: UIColor(red: 0.80, green: 0.95, blue: 0.96, alpha: 1.00)),
        ColorModel(bg: UIColor(red: 0.42, green: 0.17, blue: 0.44, alpha: 1.00), ct: UIColor(red: 0.94, green: 0.54, blue: 0.36, alpha: 1.00), bt: UIColor(red: 0.98, green: 0.93, blue: 0.41, alpha: 1.00), bd: UIColor(red: 0.72, green: 0.23, blue: 0.37, alpha: 1.00)),
        ColorModel(bg: UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00), ct: UIColor(red: 0.22, green: 0.24, blue: 0.27, alpha: 1.00), bt: UIColor(red: 0.13, green: 0.16, blue: 0.19, alpha: 1.00), bd: UIColor(red: 0.00, green: 0.68, blue: 0.71, alpha: 1.00)),
        ColorModel(bg: UIColor(red: 0.07, green: 0.18, blue: 0.31, alpha: 1.00), ct: UIColor(red: 0.86, green: 0.89, blue: 0.94, alpha: 1.00), bt: UIColor(red: 0.98, green: 0.97, blue: 0.97, alpha: 1.00), bd: UIColor(red: 0.25, green: 0.45, blue: 0.69, alpha: 1.00))
    ]
    
    static func currentTheme() -> ColorModel {
        let currentTheme = UserDefaults.standard.value(forKey: "theme") as! Int
        return listTheme[currentTheme]
    }
}
