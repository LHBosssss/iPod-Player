//
//  ThemeSelectController.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/31/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit

class ThemeSelectController: UIViewController {
    
    private let themesTable: UITableView = {
        let themes = UITableView()
        themes.translatesAutoresizingMaskIntoConstraints = false
        themes.rowHeight = 50
        return themes
    }()
    private let themes = Theme.listTheme
    private var currentRow = 0 {
        didSet {
            changeTheme()
        }
    }
    // SUPER VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupThemesTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        MenuController.iPod.clickWheelView.delegate = self
        themesTable.backgroundColor = Theme.currentMode().bgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentRow = UserDefaults.standard.value(forKey: "theme") as! Int
        changeTheme()
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupThemesTable() {
        self.view.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height / 2 - 50)
        themesTable.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        themesTable.dataSource = self
        view.addSubview(themesTable)
        themesTable.frame = view.frame
        print("created themeselection")
    }
    
    private func changeTheme() {
        print(currentRow)
        let selectedTheme = themes[currentRow]
        MenuController.iPod.changeTheme(color: selectedTheme)
        themesTable.backgroundColor = Theme.currentMode().bgColor
        themesTable.reloadData()
        themesTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .middle)
    }
}

extension ThemeSelectController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "themeCell")
        let bgColorView = UIView()
        bgColorView.backgroundColor = Theme.listTheme[currentRow].borderColor
        cell.selectedBackgroundView = bgColorView
        
        let selectedTheme = UserDefaults.standard.value(forKey: "theme") as! Int
        if indexPath.row == selectedTheme {
            cell.accessoryType = .checkmark
        }
        let mode = Theme.currentMode()
        cell.backgroundColor = mode.bgColor
        cell.textLabel?.textColor = mode.textColor
        cell.imageView?.image = UIImage(systemName: "square.stack.3d.down.right.fill")!.withTintColor(mode.textColor, renderingMode: .alwaysOriginal)
        cell.textLabel?.text = String(indexPath.row + 1)
        return cell
    }
}


extension ThemeSelectController: ControlRotationDelegate {
    func rotateClockwise() {
        currentRow = currentRow + 1 > themes.count - 1 ? themes.count - 1 : currentRow + 1
        themesTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func rotateAnticlockwise() {
        currentRow = currentRow - 1 < 0 ? 0 : currentRow - 1
        themesTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)

        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func menuButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func selectButtonPressed() {
        UserDefaults.standard.set(currentRow, forKey: "theme")
        changeTheme()
    }
}

