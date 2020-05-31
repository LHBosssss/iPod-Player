//
//  InformationCell.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/30/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit

class InformationCell: UITableViewCell {
    var cellImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.layer.borderColor = UIColor.systemGray4.cgColor
        image.layer.borderWidth = 1
        return image
    }()
    
    var cellTitle: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .left
        text.numberOfLines = 1
        text.textColor = UIColor.label
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    
    var cellDescription: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .left
        text.numberOfLines = 1
        text.textColor = UIColor.label
        text.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        let selectedView = UIView()
        selectedView.backgroundColor = Theme.currentTheme().borderColor
        self.selectedBackgroundView = selectedView
        self.addSubview(cellImage)
        cellImage.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        cellImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cellImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        self.addSubview(cellTitle)
        cellTitle.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellTitle.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 20).isActive = true
        cellTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        self.addSubview(cellDescription)
        cellDescription.topAnchor.constraint(equalTo: centerYAnchor, constant: 5).isActive = true
        cellDescription.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 20).isActive = true
        cellDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
    }
}
