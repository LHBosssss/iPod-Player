//
//  SongsController.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/27/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import MediaPlayer

class SongsController: UIViewController {
    
    var songsCollection: MPMediaItemCollection? {
        didSet {
            guard let collection = songsCollection else { return }
            listSongs = collection.items
            songsTable.reloadData()
        }
    }
    
    private let songsTable: UITableView = {
        let songs = UITableView()
        songs.translatesAutoresizingMaskIntoConstraints = false
        songs.rowHeight = 50
        return songs
    }()
    private var listSongs = [MPMediaItem]()
    private var currentRow = 0
    
    // SUPER VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSongsTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        MenuController.iPod.clickWheelView.delegate = self
        songsTable.backgroundColor = Theme.currentMode().bgColor

        songsTable.reloadData()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        songsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .none)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupSongsTable() {
        self.view.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height / 2 - 50)
        songsTable.dataSource = self
        songsTable.rowHeight = 50
        songsTable.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        songsTable.register(InformationCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(songsTable)
        songsTable.frame = view.frame
    }
    
    func handleSelectButton() {
        if MusicPlayer.mediaPlayer.nowPlayingItem == listSongs[currentRow] {
            let nextView = NowPlayingController()
            self.navigationController?.pushViewController(nextView, animated: true)
            print("Now Playing View")
        } else {
            var songsArray = Array(listSongs[currentRow...])
            songsArray.append(contentsOf: Array(listSongs[..<currentRow]))
            let songsCollection = MPMediaItemCollection(items: songsArray)
            let nextView = NowPlayingController()
            nextView.willPlayCollection = songsCollection
            self.navigationController?.pushViewController(nextView, animated: true)
        }
        
    }
}

extension SongsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = listSongs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InformationCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .gray
        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .light)
        let defaultIcon = UIImage(systemName: "music.note", withConfiguration: config)!.withTintColor(UIColor.label, renderingMode: .alwaysOriginal)
        cell.cellImage.image = item.artwork?.image(at: CGSize(width: 40, height: 40)) ?? defaultIcon
        cell.cellTitle.text = item.title ?? ""
        cell.cellDescription.text = item.artist ?? "Không có Tên Ca sĩ"
        return cell
    }
}

extension SongsController: ControlRotationDelegate {
    func rotateClockwise() {
        currentRow += 1
        currentRow = currentRow > listSongs.count - 1 ? listSongs.count - 1 : currentRow
        songsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func rotateAnticlockwise() {
        currentRow -= 1
        currentRow = currentRow < 0 ? 0 : currentRow
        songsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
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
