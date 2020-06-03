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

    var albums: [MPMediaItemCollection]? {
        didSet {
            guard let albumsModels = albums else { return }
            listAlbums = albumsModels
            collectionView.reloadData()
        }
    }
    
    var showAllSongs = false
    private var listAlbums = [MPMediaItemCollection]()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        MenuController.iPod.clickWheelView.delegate = self
        collectionView.backgroundColor = Theme.currentMode().bgColor
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionView.selectItem(at: IndexPath(row: currentItem, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        print("viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupCollectionView() {
        print(view.frame)
        print(collectionView.frame)
        self.collectionView.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height / 2 - 50)
    }
    
    func handleSelectButton() {
        let songsCollection = listAlbums[currentItem]
        let songsView = SongsController()
        songsView.songsCollection = songsCollection
        self.navigationController?.pushViewController(songsView, animated: true)
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
        cell.albumCollection = listAlbums[indexPath.item]
        if indexPath.item == 0 && showAllSongs {
            cell.isAllSongsCollection = true
        }

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
        let viewWidth = view.frame.width
        print(viewWidth)
        let itemWidth = (viewWidth - 40) * 0.75
        print(itemWidth)
        let inset = (viewWidth - itemWidth - 40) / 2
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension AlbumsController: ControlRotationDelegate {
    func rotateClockwise() {
        print("rotateClockwise")
        currentItem += 1
        currentItem = currentItem > listAlbums.count - 1 ? listAlbums.count - 1 : currentItem
        collectionView.selectItem(at: IndexPath(row: currentItem, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func rotateAnticlockwise() {
        print("rotateAnticlockwise")
        currentItem -= 1
           currentItem = currentItem < 0 ? 0 : currentItem
        collectionView.selectItem(at: IndexPath(row: currentItem, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        
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
