//
//  ArtistsController.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/27/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import MediaPlayer

class ArtistsController: UIViewController {
    
    private let artistsTable: UITableView = {
        let artists = UITableView()
        artists.translatesAutoresizingMaskIntoConstraints = false
        return artists
    }()
    
    private var listArtists = [ArtistModel]()
    private var currentRow = 0
    
    // SUPER VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = true
        setupArtistsTable()
        getArtists()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        MenuController.iPod.clickWheelView.delegate = self
        artistsTable.backgroundColor = Theme.currentMode().bgColor

    }
    override func viewDidAppear(_ animated: Bool) {
          artistsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .none)
      }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupArtistsTable() {
        self.view.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height / 2 - 50)
        artistsTable.dataSource = self
        artistsTable.register(InformationCell.self, forCellReuseIdentifier: "cell")
        artistsTable.rowHeight = 50
        artistsTable.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        view.addSubview(artistsTable)
        artistsTable.frame = view.frame
    }
    
    func getArtists() {
        let artistQuery = MPMediaQuery.artists()
        if let artists = artistQuery.collections {
            for artist in artists {
                if let item = artist.representativeItem {
                    let title = artist.representativeItem?.value(forProperty: MPMediaItemPropertyArtist) as! String
                    
                    let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .light)
                    let defaultIcon = UIImage(systemName: "person.crop.square", withConfiguration: config)!.withTintColor(UIColor.label, renderingMode: .alwaysOriginal)
                    
                    let image = item.artwork?.image(at: CGSize(width: 40, height: 40)) ?? defaultIcon
                    // Get Album
                    let predicate = MPMediaPropertyPredicate(value: title, forProperty: MPMediaItemPropertyArtist, comparisonType: .contains)
                    let filterSet = Set([predicate])
                    let albumsQuery = MPMediaQuery(filterPredicates: filterSet)
                    albumsQuery.groupingType = .album
                    var albumsCollection = albumsQuery.collections ?? [MPMediaItemCollection]()
                    let albumsCount = albumsCollection.count
                    albumsQuery.groupingType = .title
                    if let allSongs = albumsQuery.items {
                        let songsCollection = MPMediaItemCollection(items: allSongs)
                        albumsCollection.insert(songsCollection, at: 0)
                        print("Get all Songs \(allSongs.count)")
                    }
                    let songs = albumsQuery.items?.count ?? 0
                    let artistModel = ArtistModel(title: title, image: image, albums: albumsCount, songs: songs, collection: albumsCollection)
                    listArtists.append(artistModel)
                }
            }
        }
        artistsTable.reloadData()
        if listArtists.count > 0 {
            artistsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        }        
    }
    
    @objc func handleSelectButton() {
        let artist = listArtists[currentRow]
        let albumsCollection = artist.albumCollection
        
        let frame = artistsTable.frame
        print(frame)
        let layout = UICollectionViewFlowLayout()
        let size = self.artistsTable.frame.width * 0.75
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .horizontal
        let albumsView = AlbumsController(collectionViewLayout: layout)
        albumsView.collectionView.frame = frame
        albumsView.albums = albumsCollection
        albumsView.showAllSongs = true
        self.navigationController?.pushViewController(albumsView, animated: true)
    }
}

extension ArtistsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArtists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artist = listArtists[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InformationCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .gray
        cell.cellImage.image = artist.image
        cell.cellTitle.text = artist.title
        cell.cellDescription.text = "\(artist.albums) Albums - \(artist.songs) Bài hát"
        return cell
    }
}

extension ArtistsController: ControlRotationDelegate {
    func rotateClockwise() {
        currentRow += 1
        currentRow = currentRow > listArtists.count - 1 ? listArtists.count - 1 : currentRow
        artistsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func rotateAnticlockwise() {
        currentRow -= 1
        currentRow = currentRow < 0 ? 0 : currentRow
        artistsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
        
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
