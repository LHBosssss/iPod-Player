//
//  Playlists.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/27/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import MediaPlayer

class PlaylistsController: UIViewController {
    
    private let playlistsTable: UITableView = {
        let playlists = UITableView()
        playlists.translatesAutoresizingMaskIntoConstraints = false
        return playlists
    }()
    
    private var listPlaylists = [MPMediaPlaylist]()
    private var currentRow = 0
    
    // SUPER VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.systemBackground
        navigationController?.navigationBar.isHidden = true
        setupPlaylistsTable()
        getPlaylists()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.iPodV.delegate = self
        
        let theme = UserDefaults.standard.value(forKey: "theme") as! Int
        let bgColor = Theme.listTheme[theme].bgColor
        playlistsTable.backgroundColor = bgColor
        guard let selectedCell = playlistsTable.indexPathForSelectedRow else {return}
        playlistsTable.reloadData()
        playlistsTable.selectRow(at: selectedCell, animated: true, scrollPosition: .none)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupPlaylistsTable() {
        self.view.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height / 2 - 50)
        playlistsTable.dataSource = self
        playlistsTable.rowHeight = 50
        playlistsTable.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        view.addSubview(playlistsTable)
        playlistsTable.frame = view.frame
        print(playlistsTable.frame)
        print(self.view.frame)
    }
    
    func getPlaylists() {
        let playlists: [MPMediaPlaylist] = MPMediaQuery.playlists().collections! as! [MPMediaPlaylist]
        listPlaylists.append(contentsOf: playlists)
        playlistsTable.reloadData()
    }
    
    func handleSelectButton() {
        print("Selected")
        let playlistCollection = listPlaylists[currentRow]
        let songs = playlistCollection.items
        let songsCollection = MPMediaItemCollection(items: songs)
        print("created")
        let songsView = SongsController()
        songsView.songsCollection = songsCollection
        self.navigationController?.pushViewController(songsView, animated: true)
    }
}

extension PlaylistsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPlaylists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = listPlaylists[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        print(cell)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .gray
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let defaultIcon = UIImage(systemName: "music.note.list", withConfiguration: config)!.withTintColor(UIColor.label, renderingMode: .alwaysOriginal)
        cell.imageView?.image = defaultIcon
        cell.textLabel?.text = model.name ?? ""
        cell.detailTextLabel?.text = "\(model.count) Bài hát"
        
        let theme = UserDefaults.standard.value(forKey: "theme") as! Int
        let bgColorView = UIView()
        let bgColor = Theme.listTheme[theme]
        bgColorView.backgroundColor = bgColor.borderColor
        cell.selectedBackgroundView = bgColorView
        return cell
    }
}

extension PlaylistsController: ControlRotationDelegate {
    func rotateClockwise() {
        currentRow += 1
        currentRow = currentRow > listPlaylists.count - 1 ? listPlaylists.count - 1 : currentRow
        playlistsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func rotateAnticlockwise() {
        currentRow -= 1
        currentRow = currentRow < 0 ? 0 : currentRow
        playlistsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
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
