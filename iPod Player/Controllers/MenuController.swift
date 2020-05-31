//
//  ViewController.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import MediaPlayer

class MenuController: UIViewController {
    
    private let menuTable: UITableView = {
        let menu = UITableView()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.rowHeight = 50
        return menu
    }()
    private var menu = Menu.listMenu
    var currentRow = 0
    var lastPoint = CGPoint(x: 0, y: 0)
    // SUPER VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = true
        setupMenuView()
        checkUserDefault()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.iPodV.delegate = self
        guard let selectedCell = menuTable.indexPathForSelectedRow else {return}
        menuTable.reloadData()
        menuTable.selectRow(at: selectedCell, animated: true, scrollPosition: .none)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
  
    func checkUserDefault() {
        var theme = 0
        if isKeyPresentInUserDefaults(key: "theme") {
            theme = UserDefaults.standard.value(forKey: "theme") as! Int
        } else {
            UserDefaults.standard.set(0, forKey: "theme")
        }
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.changeTheme(color: Theme.listTheme[theme])
        
        if !isKeyPresentInUserDefaults(key: "shuffle") {
            MusicPlayer.mediaPlayer.shuffleMode = .songs
            let shuffle = MusicPlayer.mediaPlayer.shuffleMode
            var shuffleMode = "shuffle"
            switch shuffle {
            case .songs:
                shuffleMode = "shuffle"
            default:
                shuffleMode = "square"
            }
            UserDefaults.standard.set(shuffleMode, forKey: "shuffle")
        }
        
        if !isKeyPresentInUserDefaults(key: "repeat") {
            let repeatMode = MusicPlayer.mediaPlayer.repeatMode
            var repeateName = "repeat"
            switch repeatMode {
            case .one:
                repeateName = "repeat.1"
            case .all:
                repeateName = "repeat"
            case .none:
                repeateName = "square"
            default:
                repeateName = "repeat"
            }
            UserDefaults.standard.set(repeateName, forKey: "repeat")        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.value(forKey: key) != nil
    }

    
    func setupMenuView() {
        self.view.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height / 2 - 50)
        menuTable.dataSource = self
        menuTable.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        view.addSubview(menuTable)
        menuTable.frame = view.frame
        menuTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
    }
    
    func handleSelectButton() {
        if let index = menuTable.indexPathForSelectedRow {
            switch index.row {
            case 0:
                print(menu[0].title)
                selectedNowPlaying()
            case 1:
                print(menu[1].title)
                selectedSongs()
            case 2:
                print(menu[2].title)
                selectedPlaylists()
            case 3:
                print(menu[3].title)
                selectedAlbums()
            case 4:
                print(menu[4].title)
                selectedArtists()
            case 5:
                print(menu[5].title)
                selectedShuffle()
            case 6:
                print(menu[6].title)
                selectedSettings()
            default:
                print(menu[0].title)
            }
        }
        print("handleSelectButton")
        
    }
    
    func selectedNowPlaying() {
        let nowPlayingView = NowPlayingController()
        self.navigationController?.pushViewController(nowPlayingView, animated: true)
    }
    
    func selectedSongs() {
        let nextView = SongsController()
        if let mediaItems = MPMediaQuery.songs().items {
            nextView.songsCollection = MPMediaItemCollection(items: mediaItems)
        }
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func selectedPlaylists() {
        let nextView = PlaylistsController()
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func selectedAlbums() {
        var listAlbums = [MPMediaItemCollection]()
        let albums = MPMediaQuery.albums()
        if let albumsArray = albums.collections {
            for collection in albumsArray {
                listAlbums.append(collection)
            }
        }
        let frame = menuTable.frame
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 300)
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .horizontal
        let nextView = AlbumsController(collectionViewLayout: layout)
        nextView.collectionView.frame = frame
        nextView.albums = listAlbums
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func selectedArtists() {
        let nextView = ArtistsController()
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func selectedShuffle() {
        let nextView = SongsController()
        if var mediaItems = MPMediaQuery.songs().items {
            mediaItems.shuffle()
            nextView.songsCollection = MPMediaItemCollection(items: mediaItems)
        }
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    
    func selectedSettings() {
        let nextView = SettingsController()
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}

extension MenuController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = menu[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "menuCell")
        cell.imageView?.image = model.image.withTintColor(UIColor.label, renderingMode: .alwaysOriginal)
        cell.textLabel?.text = model.title
        cell.accessoryType = .disclosureIndicator
        let bgColorView = UIView()
        bgColorView.backgroundColor = Theme.currentTheme().borderColor
        cell.selectedBackgroundView = bgColorView
        return cell
    }
}

extension MenuController: ControlRotationDelegate {
    func rotateClockwise() {
        print("rotateClockwise")
        currentRow += 1
        currentRow = currentRow > menu.count - 1 ? menu.count - 1 : currentRow
        menuTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func rotateAnticlockwise() {
        print("rotateAnticlockwise")
        currentRow -= 1
        currentRow = currentRow < 0 ? 0 : currentRow
        menuTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func menuButtonPressed() {
        return
    }
    
    func selectButtonPressed() {
        self.handleSelectButton()
    }
}
