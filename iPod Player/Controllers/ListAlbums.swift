//
//  ListAlbums.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbumsController: UICollectionViewController {

    var albums: [AlbumModel]? {
        didSet {
            guard let albumsModels = albums else { return }
            listAlbums = albumsModels
            collectionView.reloadData()
        }
    }
    
    private var listAlbums = [AlbumModel]()
    private var currentItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(AlbumCell.self, forCellWithReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        setupCollectionView()
        getAlbums()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.iPodV.forwardButton.addTarget(self, action: #selector(handleForwardButton), for: .touchUpInside)
        sceneDelegate.iPodV.backwardButton.addTarget(self, action: #selector(handleBackwardButton), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.iPodV.forwardButton.removeTarget(nil, action: nil, for: .allEvents)
        sceneDelegate.iPodV.backwardButton.removeTarget(nil, action: nil, for: .allEvents)
    }
    
    func setupCollectionView() {
        print(view.frame)
        print(collectionView.frame)
        self.collectionView.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height / 2 - 50)
        collectionView.backgroundColor = UIColor.white
    }
    
    func getAlbums() {
        let everything = MPMediaQuery.albums().collections
        let albums = MPMediaQuery.albums()
        for item in everything! {
            print(item.representativeItem?.albumTitle)
            print(item.count)
        }
        if let albumsArray = albums.collections {
            for collection in albumsArray {
                if let albumItem = collection.representativeItem {
                    let title = albumItem.albumTitle ?? "Không có Tên"
                    let image = albumItem.artwork?.image(at: CGSize(width: 300, height: 300)) ??  UIImage(systemName: "music.note")!
                    let artist = albumItem.albumArtist ?? "Không có Tên"
                    let count = collection.count
                    print("Track count = \(count)")
                    let album = AlbumModel(title: title, image: image, artist: artist, count: count)
                    listAlbums.append(album)
                }
            }
            print("Count = \(listAlbums.count)")
            collectionView.reloadData()
        }
    }
    
    
    @objc func handleForwardButton() {
        currentItem += 1
        currentItem = currentItem > listAlbums.count - 1 ? listAlbums.count - 1 : currentItem
        collectionView.selectItem(at: IndexPath(row: currentItem, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    @objc func handleBackwardButton() {
     currentItem -= 1
        currentItem = currentItem < 0 ? 0 : currentItem
     collectionView.selectItem(at: IndexPath(row: currentItem, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return listAlbums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumCell
    
        cell.cellModel = listAlbums[indexPath.item]
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
        let cell = collectionView.cellForItem(at: indexPath) as! AlbumCell
            cell.layer.borderWidth = 10
            cell.layer.borderColor = UIColor.white.cgColor
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselected")
        let cell = collectionView.cellForItem(at: indexPath) as! AlbumCell
            cell.layer.borderWidth = 5
            cell.layer.borderColor = UIColor.gray.cgColor
    }
}


extension AlbumsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
