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
        MenuCellModel(title: "Appearance", image: "tv.music.note"),
        MenuCellModel(title: "Theme", image: "paintbrush"),
    ]
}
