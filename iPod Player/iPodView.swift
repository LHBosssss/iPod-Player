//
//  iPodView.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
@objc protocol ControlRotationDelegate {
    func rotateClockwise()
    func rotateAnticlockwise()
    func menuButtonPressed()
    func selectButtonPressed()
    @objc optional func beginRotate()
    @objc optional func endRotate()
    @objc optional func holdSelectButton()
}

class iPodView: UIView {
    
    var controlView: UIView = {
        let control = UIView()
        control.isUserInteractionEnabled = true
        control.backgroundColor = UIColor().bg()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.layer.masksToBounds = true
        control.layer.borderWidth = 3
        control.layer.borderColor = UIColor.white.cgColor
        control.clipsToBounds = true
        return control
    }()
    
    var selectButton: UIButton = {
        let select = UIButton()
        select.translatesAutoresizingMaskIntoConstraints = false
        select.backgroundColor = UIColor.white
        select.tintColor = UIColor.white
        select.layer.borderColor = UIColor.blue.cgColor
        select.layer.borderWidth = 3
        select.layer.masksToBounds = true
//        select.addTarget(self, action: #selector(handleSelectButton), for: .touchUpInside)
//        select.addTarget(self, action: #selector(handleSelectButtonHold), for: .touchDown)
        return select
    }()
    
    var menuButton: UIButton = {
        let menu = UIButton()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.setTitle("MENU", for: .normal)
        menu.tintColor = UIColor.white
        menu.setTitleColor(UIColor.white, for: .normal)
        menu.setTitleColor(UIColor.gray, for: .highlighted)
        menu.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
        return menu
    }()
    
    var playPauseButton: UIButton = {
        let playPause = UIButton()
        playPause.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy)
        playPause.tintColor = UIColor.white
        playPause.setTitleColor(UIColor.white, for: .normal)
        playPause.setImage(UIImage(systemName: "playpause.fill", withConfiguration: config)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal), for: .normal)
        playPause.addTarget(self, action: #selector(handlePlayPauseButton), for: .touchUpInside)
        return playPause
    }()
    
    var forwardButton: UIButton = {
        let forward = UIButton()
        forward.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy)
        forward.tintColor = UIColor.white
        forward.setTitleColor(UIColor.white, for: .normal)
        forward.setImage(UIImage(systemName: "forward.end.alt.fill", withConfiguration: config)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal), for: .normal)
        forward.addTarget(self, action: #selector(handleForwardButton), for: .touchUpInside)
        return forward
    }()
    
    var backwardButton: UIButton = {
        let backward = UIButton()
        backward.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy)
        backward.tintColor = UIColor.white
        backward.setTitleColor(UIColor.white, for: .normal)
        backward.setImage(UIImage(systemName: "backward.end.alt.fill", withConfiguration: config)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal), for: .normal)
        backward.addTarget(self, action: #selector(handleBackwardButton), for: .touchUpInside)
        return backward
    }()
    
    enum TouchPosition {
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
        case none
    }
    
    var lastPoint = CGPoint(x: 0, y: 0)
    var delegate: ControlRotationDelegate?
    var touchBeginPosition: TouchPosition?
    var observerToken: NSKeyValueObservation?
    // SUPER INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.clear
        self.translatesAutoresizingMaskIntoConstraints = false
        setupControlView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupControlView() {
        observerToken = UserDefaults.standard.observe(\.themeIndex, options: [.new, .old]) { (object, change) in
            print("Change is \(object.themeIndex)")
        }
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture))
        controlView.addGestureRecognizer(panGesture)
        self.addSubview(controlView)
        controlView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        controlView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        controlView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        controlView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        controlView.layer.cornerRadius = 150
        controlView.layer.masksToBounds = true
        controlView.clipsToBounds = true
        
        // Center Button - Select Button
        controlView.addSubview(selectButton)
        selectButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        selectButton.centerXAnchor.constraint(equalTo: controlView.centerXAnchor).isActive = true
        selectButton.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        selectButton.layer.cornerRadius = 50
        selectButton.layer.masksToBounds = true
        selectButton.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectButton))
        selectButton.addGestureRecognizer(tapGesture)
        let holdGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleSelectButtonHold))
        selectButton.addGestureRecognizer(holdGesture)
        
        // Menu Button
        controlView.addSubview(menuButton)
        menuButton.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 15).isActive = true
        menuButton.centerXAnchor.constraint(equalTo: controlView.centerXAnchor).isActive = true
        
        // Play Pause Button
        controlView.addSubview(playPauseButton)
        playPauseButton.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -15).isActive = true
        playPauseButton.centerXAnchor.constraint(equalTo: controlView.centerXAnchor).isActive = true
        
        // Forward Button
        controlView.addSubview(forwardButton)
        forwardButton.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -15).isActive = true
        forwardButton.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        
        // Backward Button
        controlView.addSubview(backwardButton)
        backwardButton.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: 15).isActive = true
        backwardButton.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        
    }
    
    func setControlColor(color: ColorModel) {
        controlView.backgroundColor = color.controlColor
        controlView.layer.borderColor = color.borderColor.cgColor
        
        menuButton.setTitleColor(color.buttonColor, for: .normal)
        
        selectButton.backgroundColor = color.bgColor
        selectButton.layer.borderColor = color.borderColor.cgColor
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy)
        playPauseButton.setImage(UIImage(systemName: "playpause.fill", withConfiguration: config)?.withTintColor(color.buttonColor, renderingMode: .alwaysOriginal), for: .normal)
        forwardButton.setImage(UIImage(systemName: "forward.end.alt.fill", withConfiguration: config)?.withTintColor(color.buttonColor, renderingMode: .alwaysOriginal), for: .normal)
        backwardButton.setImage(UIImage(systemName: "backward.end.alt.fill", withConfiguration: config)?.withTintColor(color.buttonColor, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    
    
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        
        if panGesture.state == UIGestureRecognizer.State.began {
            lastPoint = CGPoint(x: 0, y: 0)
            self.delegate?.beginRotate?()
        }
        
        if panGesture.state == UIGestureRecognizer.State.ended {
            self.delegate?.endRotate?()
        }
        
        
        if panGesture.state == UIGestureRecognizer.State.changed {
            let location = panGesture.location(in: self)
            let currentPoint = panGesture.translation(in: controlView)
            let currentVelocity = panGesture.velocity(in: controlView)
            let position = touchInPosition(touch: location)
            checkClockwise(current: currentPoint, velocity: currentVelocity, position: position)
        }
    }
    
    func touchInPosition(touch: CGPoint) -> TouchPosition {
        let center = self.controlView.center
        if touch.x > 0 && touch.y > 0 && touch.x > center.x {
            if touch.y > center.y {
                return TouchPosition.bottomRight
            } else {
                return TouchPosition.topRight
            }
        }
        if touch.x > 0 && touch.y > 0 && touch.x < center.x {
            if touch.y > center.y {
                return TouchPosition.bottomLeft
            } else {
                return TouchPosition.topLeft
            }
        }
        return .none
    }
    
    
    func checkClockwise(current: CGPoint, velocity: CGPoint, position: TouchPosition) {
        if current.x < lastPoint.x && current.y > lastPoint.y && current.y - lastPoint.y > 20 {
            //            print("top -> down - left")
            self.lastPoint = current
            if position == .topLeft {
                self.delegate?.rotateAnticlockwise()
                return
            }
            if position == .bottomRight {
                self.delegate?.rotateClockwise()
                return
            }
        }
        if current.x > lastPoint.x && current.y > lastPoint.y && current.y - lastPoint.y > 20 {
            //            print("top -> down - right")
            self.lastPoint = current
            if position == .topRight {
                self.delegate?.rotateClockwise()
                return
            }
            if position == .bottomLeft {
                self.delegate?.rotateAnticlockwise()
                return
            }
        }
        if current.x > lastPoint.x && current.y < lastPoint.y && lastPoint.y - current.y > 20 {
            //            print("down -> top - right")
            self.lastPoint = current
            if position == .topLeft {
                self.delegate?.rotateClockwise()
                return
            }
            if position == .bottomRight {
                self.delegate?.rotateAnticlockwise()
                return
            }
        }
        if current.x < lastPoint.x && current.y < lastPoint.y && lastPoint.y - current.y > 20 {
            //            print("down -> top - left")
            self.lastPoint = current
            if position == .topRight {
                self.delegate?.rotateAnticlockwise()
                return
            }
            if position == .bottomLeft {
                self.delegate?.rotateClockwise()
                return
            }
        }
    }
    
    @objc func handleMenuButton() {
        self.delegate?.menuButtonPressed()
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    @objc func handleSelectButton() {
        self.delegate?.selectButtonPressed()
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    @objc func handleSelectButtonHold() {
        self.delegate?.holdSelectButton?()
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    @objc func handlePlayPauseButton () {
        let state = MusicPlayer.mediaPlayer.playbackState
        if state == .playing {
            MusicPlayer.mediaPlayer.pause()
        }
        if state == .paused {
            MusicPlayer.mediaPlayer.play()
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    @objc func handleForwardButton() {
        MusicPlayer.mediaPlayer.skipToNextItem()
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    @objc func handleBackwardButton() {
        MusicPlayer.mediaPlayer.skipToPreviousItem()
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

extension UIColor {
    func bg() -> UIColor {
        return UIColor(red: 0.08, green: 0.16, blue: 0.31, alpha: 1.00)
    }
}

extension UserDefaults {
    @objc dynamic var themeIndex: Int {
        get {
            return Int(integer(forKey: "themeIndex"))
        }
        set {
            set(newValue, forKey: "themeIndex")
        }
    }
}
