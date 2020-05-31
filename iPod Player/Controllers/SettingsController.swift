//
//  SettingsController.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/28/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import MediaPlayer

class SettingsController: UIViewController {
    
    private let settingTable: UITableView = {
        let setting = UITableView()
        setting.translatesAutoresizingMaskIntoConstraints = false
        setting.rowHeight = 50
        return setting
    }()
    private let settings = Menu.listSettings
    private var currentRow = 0
    // SUPER VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        MenuController.iPod.clickWheelView.delegate = self
        settingTable.backgroundColor = Theme.currentMode().bgColor
        if let selectedCell = settingTable.indexPathForSelectedRow {
            settingTable.reloadData()
            settingTable.selectRow(at: selectedCell, animated: true, scrollPosition: .none)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        settingTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .none)
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupSettingTable() {
        self.view.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height / 2 - 50)
        settingTable.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        settingTable.dataSource = self
        view.addSubview(settingTable)
        settingTable.frame = view.frame
        settingTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
    }
    
    func handleSelectButton() {
        let theme = Theme.listTheme
        switch currentRow {
        case 0:
            var shuffleName = UserDefaults.standard.value(forKey: "shuffle") as! String
            switch shuffleName {
            case "shuffle":
                shuffleName = "square"
            default:
                shuffleName = "shuffle"
            }
            UserDefaults.standard.set(shuffleName, forKey: "shuffle")
            settingTable.reloadData()
        case 1:
            var repeateName = UserDefaults.standard.value(forKey: "repeat") as! String
            switch repeateName {
            case "repeat.1":
                repeateName = "repeat"
            case "repeat":
                repeateName = "square"
            case "square":
                repeateName = "repeat.1"
            default:
                repeateName = "repeat"
            }
            UserDefaults.standard.set(repeateName, forKey: "repeat")
            settingTable.reloadData()
        case 2:
            let currentMode = UserDefaults.standard.value(forKey: "mode") as! String
            var nextMode = ""
            if currentMode == "Light" {
                nextMode = "Dark"
            } else {
                nextMode = "Light"
            }
            UserDefaults.standard.set(nextMode, forKey: "mode")
            settingTable.reloadData()
        case 3:
            let themesView = ThemeSelectController()
            self.navigationController?.pushViewController(themesView, animated: true)
        default:
            print("Default")
            MenuController.iPod.changeTheme(color: theme[1])
        }
        
        settingTable.backgroundColor = Theme.currentMode().bgColor
        settingTable.reloadData()
        settingTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .none)
    }
}

extension SettingsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = settings[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "settingCell")
        cell.accessoryType = .disclosureIndicator
        let bgColorView = UIView()
        bgColorView.backgroundColor = Theme.currentTheme().borderColor
        cell.selectedBackgroundView = bgColorView
        
        let mode = Theme.currentMode()
        cell.backgroundColor = mode.bgColor
        cell.textLabel?.textColor = mode.textColor
        cell.detailTextLabel?.textColor = mode.textColor
        cell.imageView?.image = item.image.withTintColor(mode.textColor, renderingMode: .alwaysOriginal)
        cell.textLabel?.text = item.title
        
        var description = ""
        switch item.title {
        case "Shuffle":
            let shuffleName = UserDefaults.standard.value(forKey: "shuffle") as! String
            switch shuffleName {
            case "square":
                description = "Off"
            default:
                description = "On"
            }
        case "Repeat":
            let repeateName = UserDefaults.standard.value(forKey: "repeat") as! String
            switch repeateName {
            case "repeat.1":
                description = "One"
            case "repeat":
                description = "All"
            case "square":
                description = "Off"
            default:
                description = "All"
            }
            
        case "Appearance":
            let currentMode = UserDefaults.standard.value(forKey: "mode") as! String
            description = currentMode
            
        case "Theme":
            let currentTheme = UserDefaults.standard.value(forKey: "theme") as! Int
            description = String(currentTheme + 1)
            
        default:
            description = ""
        }
        cell.detailTextLabel?.text = description
        return cell
    }
}


extension SettingsController: ControlRotationDelegate {
    func rotateClockwise() {
        currentRow += 1
        currentRow = currentRow > settings.count - 1 ? settings.count - 1 : currentRow
        settingTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func rotateAnticlockwise() {
        currentRow -= 1
        currentRow = currentRow < 0 ? 0 : currentRow
        settingTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func menuButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func selectButtonPressed() {
        self.handleSelectButton()
    }
}
