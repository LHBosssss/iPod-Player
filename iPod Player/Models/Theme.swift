//
//  Theme.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/31/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    static var listTheme: [ThemeModel] = [
        ThemeModel(bg: .white, bd: .darkGray, ct: .white, bt: .black),
        ThemeModel(bg: .black, bd: .lightGray, ct: .black, bt: .white),
        ThemeModel(bg: "311d3f", bd: "522546", ct: "88304e", bt: "e23e57"),
        ThemeModel(bg: "dae1e7", bd: "00909e", ct: "27496d", bt: "142850"),
        ThemeModel(bg: "355c7d", bd: "6c5b7b", ct: "c06c84", bt: "f67280"),
        ThemeModel(bg: "14ffec", bd: "0d7377", ct: "323232", bt: "212121"),
        ThemeModel(bg: "cae8d5", bd: "84a9ac", ct: "3b6978", bt: "204051"),
        ThemeModel(bg: "ffffd2", bd: "fcbad3", ct: "aa96da", bt: "a8d8ea"),
        ThemeModel(bg: "eeeeee", bd: "00adb5", ct: "393e46", bt: "222831"),
        ThemeModel(bg: "a5dee5", bd: "e0f9b5", ct: "fefdca", bt: "ffcfdf"),
        ThemeModel(bg: "e3fdfd", bd: "cbf1f5", ct: "a6e3e9", bt: "71c9ce"),
        ThemeModel(bg: "defcf9", bd: "cadefc", ct: "c3bef0", bt: "cca8e9"),
        ThemeModel(bg: "95e1d3", bd: "eaffd0", ct: "fce38a", bt: "f38181"),
        ThemeModel(bg: "8785a2", bd: "f6f6f6", ct: "ffe2e2", bt: "ffc7c7"),
        ThemeModel(bg: "fc5185", bd: "f5f5f5", ct: "3fc1c9", bt: "364f6b"),
        ThemeModel(bg: "3e4149", bd: "444f5a", ct: "ff9999", bt: "ffc8c8"),
        ThemeModel(bg: "40514e", bd: "11999e", ct: "30e3ca", bt: "e4f9f5"),
        ThemeModel(bg: "abedd8", bd: "46cdcf", ct: "3d84a8", bt: "48466d"),
        ThemeModel(bg: "ffaaa5", bd: "ffd3b6", ct: "dcedc1", bt: "a8e6cf"),
        ThemeModel(bg: "53354a", bd: "903749", ct: "e84545", bt: "2b2e4a"),
        ThemeModel(bg: "6a2c70", bd: "b83b5e", ct: "f08a5d", bt: "f9ed69"),
        ThemeModel(bg: "61c0bf", bd: "bbded6", ct: "fae3d9", bt: "ffb6b9"),
        ThemeModel(bg: "eaeaea", bd: "ff2e63", ct: "252a34", bt: "08d9d6"),
        ThemeModel(bg: "ffde7d", bd: "f6416c", ct: "f8f3d4", bt: "00b8a9"),
        ThemeModel(bg: "f9f7f7", bd: "dbe2ef", ct: "3f72af", bt: "112d4e"),
        ThemeModel(bg: "679b9b", bd: "aacfcf", ct: "fde2e2", bt: "ffb6b6"),
        ThemeModel(bg: "d9bf77", bd: "d8ebb5", ct: "639a67", bt: "2b580c"),
        ThemeModel(bg: "ff926b", bd: "ffc38b", ct: "fff3cd", bt: "4d3e3e"),
        ThemeModel(bg: "a6d0e4", bd: "f9ffea", ct: "ffecda", bt: "d4a5a5"),
        ThemeModel(bg: "e3e3e3", bd: "f95959", ct: "455d7a", bt: "233142"),
    ]
    
    
    static var modes: [ThemeModeModel] = [
        ThemeModeModel(bg: .label, tx: .systemBackground),
        ThemeModeModel(bg: .systemBackground, tx: .label)
    ]
    
    static func currentTheme() -> ThemeModel {
        let currentTheme = UserDefaults.standard.value(forKey: "theme") as! Int
        return listTheme[currentTheme]
    }
    
    static func currentMode() -> ThemeModeModel {
        let current = UserDefaults.standard.value(forKey: "mode") as! String
        if current == "Light" {
            return modes[1]
        } else {
            return modes[0]
        }
    }
}

