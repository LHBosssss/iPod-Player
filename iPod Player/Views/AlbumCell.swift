//
//  AlbumCell.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbumCell: UICollectionViewCell {
    var albumCollection: MPMediaItemCollection? {
        didSet {
            guard let item = albumCollection?.representativeItem else { return }
            let config = UIImage.SymbolConfiguration(pointSize: 150)
            let defaultIcon = UIImage(systemName: "folder", withConfiguration: config)!.withTintColor(UIColor.label, renderingMode: .alwaysOriginal)
            albumImage.image = item.artwork?.image(at: CGSize(width: 400, height: 400)) ?? defaultIcon
            albumTitle.text = item.albumTitle ?? "Không có Tên Album"
            albumSinger.text = item.albumArtist ?? "Không có Tên Ca sĩ"
            let count = String(albumCollection?.count ?? 0)
            countNumber.setTitle(count, for: .normal)
        }
    }
    
    var isAllSongsCollection: Bool? {
        didSet {
            albumTitle.text = "All Songs"
            let config = UIImage.SymbolConfiguration(pointSize: 150)
            let defaultIcon = UIImage(systemName: "music.note.list", withConfiguration: config)!.withTintColor(UIColor.label, renderingMode: .alwaysOriginal)
            albumImage.image = defaultIcon
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = Theme.currentTheme().borderColor.cgColor
            } else {
                self.layer.borderColor = Theme.currentTheme().bgColor.cgColor
            }
        }
    }
    
    private let albumImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let albumTitle: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.numberOfLines = 0
        text.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        text.textColor = UIColor.white
        text.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return text
    }()
    
    private let albumSinger: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.numberOfLines = 0
        text.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        text.textColor = UIColor.white
        text.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return text
    }()
    
    private let countNumber: UIButton = {
        let count = UIButton()
        count.isEnabled = false
        count.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        count.layer.cornerRadius = 20
        count.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        count.setTitleColor(UIColor.white, for: .normal)
        count.layer.masksToBounds = true
        return count
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = Theme.currentTheme().bgColor.cgColor
        layer.borderWidth = 5
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        addSubview(albumImage)
        albumImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        albumImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        albumImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        albumImage.addSubview(albumSinger)
        albumSinger.bottomAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: -5).isActive = true
        albumSinger.leadingAnchor.constraint(equalTo: albumImage.leadingAnchor, constant: 5).isActive = true
        albumSinger.trailingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: -5).isActive = true
        
        albumImage.addSubview(albumTitle)
        albumTitle.bottomAnchor.constraint(equalTo: albumSinger.topAnchor).isActive = true
        albumTitle.leadingAnchor.constraint(equalTo: albumImage.leadingAnchor, constant: 5).isActive = true
        albumTitle.trailingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: -5).isActive = true
        
        albumImage.addSubview(countNumber)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
