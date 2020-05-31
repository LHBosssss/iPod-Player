//
//  Menu.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import MediaPlayer

struct MusicPlayer {
    static var listSong = [MPMediaItem]()
    static var mediaPlayer = MPMusicPlayerController.systemMusicPlayer
}
