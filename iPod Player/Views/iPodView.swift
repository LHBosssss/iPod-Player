//
//  iPodView.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/31/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit

class iPodView: UIView {
    
    let clickWheelView = ClickWheelView()
    private var musicPlayer = MusicPlayer()
    private var overlayView = UIView()
    private var iPodScreen = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupiPodView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupiPodView() {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        // Create iPod Theme
        self.overlayView  = createOverlay(frame: window!.frame)
        window?.addSubview(self.overlayView)
        self.iPodScreen = createScreenBorder(frame: window!.frame)
        window?.addSubview(self.iPodScreen)
        // Create Control UI
        window?.addSubview(self.clickWheelView)
        self.clickWheelView.topAnchor.constraint(equalTo: window!.centerYAnchor).isActive = true
        self.clickWheelView.bottomAnchor.constraint(equalTo: window!.bottomAnchor).isActive = true
        self.clickWheelView.leadingAnchor.constraint(equalTo: window!.leadingAnchor).isActive = true
        self.clickWheelView.trailingAnchor.constraint(equalTo: window!.trailingAnchor).isActive = true
    }
    
    func createOverlay(frame: CGRect) -> UIView {
        let overlayView = UIView(frame: frame)
        overlayView.backgroundColor = .black
        let path = CGMutablePath()
        path.addRoundedRect(in: CGRect(x: 20, y: 50, width: frame.width - 40, height: frame.height/2 - 50), cornerWidth: 20, cornerHeight: 20)
        path.addRect(CGRect(origin: .zero, size: frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.green.cgColor
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        return overlayView
    }
    
    func createScreenBorder(frame: CGRect) -> UIView {
        let screenView = UIView(frame: CGRect(x: 20, y: 50, width: frame.width - 40, height: frame.height/2 - 50))
        screenView.layer.masksToBounds = true
        screenView.layer.cornerRadius = 20
        screenView.backgroundColor = UIColor.clear
        screenView.layer.borderColor = UIColor.lightGray.cgColor
        screenView.layer.borderWidth = 5
        return screenView
    }
    
    func changeTheme(color: ThemeModel) {
        self.overlayView.backgroundColor = color.bgColor
        self.iPodScreen.layer.borderColor = color.borderColor.cgColor
        self.clickWheelView.setControlColor(color: color)
    }
}
