//
//  NowPlayingController.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/27/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import MediaPlayer

class NowPlayingController: UIViewController {
    var willPlayCollection: MPMediaItemCollection? {
        didSet {
            guard let collection = willPlayCollection else { return }
            MusicPlayer.mediaPlayer.setQueue(with: collection)
            MusicPlayer.mediaPlayer.play()
        }
    }
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemBackground
        return view
    }()
    
    private let artworkView: UIImageView = {
        let artwork = UIImageView()
        artwork.translatesAutoresizingMaskIntoConstraints = false
        artwork.contentMode = .scaleAspectFit
        artwork.layer.masksToBounds = true
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
        artwork.image = UIImage(systemName: "music.note", withConfiguration: config)
        return artwork
    }()
    
    private let songTitle: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 20, weight: .light)
        title.textColor = UIColor.label
        title.numberOfLines = 0
        return title
    }()
    
    private let singerName: UILabel = {
        let singer = UILabel()
        singer.textAlignment = .center
        singer.translatesAutoresizingMaskIntoConstraints = false
        singer.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        singer.textColor = UIColor.label
        singer.numberOfLines = 1
        singer.adjustsFontSizeToFitWidth = true
        return singer
    }()
    
    private let trackTime: UISlider = {
        let time = UISlider()
        time.maximumTrackTintColor = UIColor.systemGray
        time.minimumTrackTintColor = UIColor.label
        time.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 6, weight: .bold)
        let thumbImage = UIImage(systemName: "circle.fill", withConfiguration: config)?.withTintColor(UIColor.label, renderingMode: .alwaysOriginal)
        time.setThumbImage(thumbImage, for: .normal)
        return time
    }()
    
    private let currentTime: UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.text = "00:00"
        time.textColor = UIColor.label
        time.numberOfLines = 1
        return time
    }()
    
    private let durationTime: UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.textColor = UIColor.label
        time.text = "00:00"
        time.numberOfLines = 1
        return time
    }()
    
    private let pauseIcon: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 15)
        let iconView = UIImageView(image: UIImage(systemName: "pause.fill", withConfiguration: config)!.withTintColor(UIColor.black, renderingMode: .alwaysOriginal))
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.isHidden = true
        return iconView
    }()
    
    private let shuffleIcon: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 15)
        let name = UserDefaults.standard.value(forKey: "shuffle") as! String
        let iconView = UIImageView(image: UIImage(systemName: name, withConfiguration: config)!.withTintColor(UIColor.black, renderingMode: .alwaysOriginal))
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.isHidden = false
        return iconView
    }()
    
    private let repeatIcon: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 15)
        let name = UserDefaults.standard.value(forKey: "repeat") as! String
        let iconView = UIImageView(image: UIImage(systemName: name, withConfiguration: config)!.withTintColor(UIColor.black, renderingMode: .alwaysOriginal))
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.isHidden = false
        return iconView
    }()
    
    private var updateTrackTime: Timer? {
        willSet {
            updateTrackTime?.invalidate()
        }
    }
    private var isSeeking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNowPlayingItem), name: Notification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlayPause), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.iPodV.delegate = self
        updateNowPlayingView()
        setRepeatMode()
        setShuffleMode()
        shuffleIcon.setNeedsDisplay()
        repeatIcon.setNeedsDisplay()
        print("Now Playing Will Appear")
    }
    
    @objc private func handleNowPlayingItem() {
        print("Now Playing Item Did Changed")
        updateNowPlayingView()
    }
    
    @objc private func handlePlayPause() {
        print("handlePlayPause")
        if MusicPlayer.mediaPlayer.playbackState == .paused {
            pauseIcon.isHidden = false
        } else {
            pauseIcon.isHidden = true
        }
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setRepeatMode() {
        let repeateName = UserDefaults.standard.value(forKey: "repeat") as! String
        switch repeateName {
        case "repeat.1":
            MPMusicPlayerController.systemMusicPlayer.repeatMode = .one
        case "repeat":
            MPMusicPlayerController.systemMusicPlayer.repeatMode = .all
        case "square":
            MPMusicPlayerController.systemMusicPlayer.repeatMode = .none
        default:
            MPMusicPlayerController.systemMusicPlayer.repeatMode = .all
        }
    }
    
    func setShuffleMode() {
        let shuffleName = UserDefaults.standard.value(forKey: "shuffle") as! String
        switch shuffleName {
        case "square":
            MPMusicPlayerController.systemMusicPlayer.shuffleMode = .off
        default:
            MPMusicPlayerController.systemMusicPlayer.shuffleMode = .songs
        }
    }
    
    func updateNowPlayingView() {
        guard let nowPlayingItem = MusicPlayer.mediaPlayer.nowPlayingItem else { return }
        songTitle.text = nowPlayingItem.title ?? "Không có Tên Bài hát"
        singerName.text = nowPlayingItem.artist ?? "Không có Tên Ca sĩ"
        let musicIcon = UIImage(named: "note")!.withTintColor(UIColor.label, renderingMode: .alwaysOriginal)
        artworkView.image = nowPlayingItem.artwork?.image(at: CGSize(width: 300, height: 300)) ?? musicIcon
        let timeInt = Int(nowPlayingItem.playbackDuration)
        let minutes = timeInt / 60
        let seconds = timeInt % 60
        durationTime.text = "\(minutes >= 10 ? String(minutes) : "0" + String(minutes)):\(seconds >= 10 ? String(seconds) : "0" + String(seconds))"
        trackTime.minimumValue = 0
        trackTime.maximumValue = Float(nowPlayingItem.playbackDuration)
        
        startUpdateCurrentTime()
        
        let shuffleName = UserDefaults.standard.value(forKey: "shuffle") as! String
        if shuffleName == "square" {
            shuffleIcon.isHidden = true
        } else {
            shuffleIcon.isHidden = false
            let config = UIImage.SymbolConfiguration(pointSize: 15)
            shuffleIcon.image = UIImage(systemName: shuffleName, withConfiguration: config)!.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        }
        
        let repeatName = UserDefaults.standard.value(forKey: "repeat") as! String
        if repeatName == "square" {
            repeatIcon.isHidden = true
        } else {
            repeatIcon.isHidden = false
            let config = UIImage.SymbolConfiguration(pointSize: 15)
            repeatIcon.image = UIImage(systemName: repeatName, withConfiguration: config)!.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        }
    }
    
    func startUpdateCurrentTime() {
        updateTrackTime = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            let time = Float(MusicPlayer.mediaPlayer.currentPlaybackTime)
            self.setTime(time: time)
        }
    }
    
    func setTime(time: Float) {
        self.trackTime.setValue(time, animated: true)
        let timeInt = Int(time)
        let minutes = timeInt / 60
        let seconds = timeInt % 60
        self.currentTime.text = "\(minutes >= 10 ? String(minutes) : "0" + String(minutes)):\(seconds >= 10 ? String(seconds) : "0" + String(seconds))"
    }
    func setupView() {
        view.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // Current Time
        contentView.addSubview(currentTime)
        currentTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        currentTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        
        // Pause icon
        contentView.addSubview(pauseIcon)
        pauseIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        pauseIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        currentTime.centerYAnchor.constraint(equalTo: pauseIcon.centerYAnchor).isActive = true
        // Repeate icon
        contentView.addSubview(repeatIcon)
        repeatIcon.leadingAnchor.constraint(equalTo: pauseIcon.trailingAnchor, constant: 5).isActive = true
        repeatIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        // Shuffle icon
        contentView.addSubview(shuffleIcon)
        shuffleIcon.trailingAnchor.constraint(equalTo: pauseIcon.leadingAnchor, constant: -5).isActive = true
        shuffleIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        // Duration Time
        contentView.addSubview(durationTime)
        durationTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        durationTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        // Track Progress
        contentView.addSubview(trackTime)
        trackTime.heightAnchor.constraint(equalToConstant: 15).isActive = true
        trackTime.bottomAnchor.constraint(equalTo: currentTime.topAnchor, constant: -10).isActive = true
        trackTime.leadingAnchor.constraint(equalTo: currentTime.leadingAnchor).isActive = true
        trackTime.trailingAnchor.constraint(equalTo: durationTime.trailingAnchor).isActive = true
        
        // Singer
        contentView.addSubview(singerName)
        singerName.bottomAnchor.constraint(equalTo: trackTime.topAnchor, constant: -5).isActive = true
        singerName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50).isActive = true
        singerName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        
        // Title
        contentView.addSubview(songTitle)
        songTitle.bottomAnchor.constraint(equalTo: singerName.topAnchor).isActive = true
        songTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        songTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        // Artwork
        contentView.addSubview(artworkView)
        artworkView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        artworkView.bottomAnchor.constraint(equalTo: songTitle.topAnchor, constant: -20).isActive =  true
        artworkView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
}

extension NowPlayingController: ControlRotationDelegate {
    func rotateClockwise() {
        if !isSeeking {
            let volumeView = MPVolumeView()
            let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                slider?.value += 0.1
                
            }
        } else {
            print("rotateClockwise")
            var time = self.trackTime.value
            time = min(time + 3, trackTime.maximumValue)
            setTime(time: time)
        }
        
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func rotateAnticlockwise() {
        if !isSeeking {
            let volumeView = MPVolumeView()
            let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                slider?.value -= 0.1
                
            }
        } else {
            print("rotateAnticlockwise")
            var time = self.trackTime.value
            time = max(time - 3, trackTime.minimumValue)
            setTime(time: time)
        }
        
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func beginRotate() {
        if !isSeeking {return}
        self.updateTrackTime = nil
    }
    
    func endRotate() {
        if !isSeeking {return}
        let time = self.trackTime.value
        MusicPlayer.mediaPlayer.play()
        MusicPlayer.mediaPlayer.currentPlaybackTime = TimeInterval(time)
        startUpdateCurrentTime()
        isSeeking = false
        setNormalThumb()
    }
    
    func menuButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func selectButtonPressed() {
        isSeeking = !isSeeking
        if isSeeking {
            setLargeThumb()
        } else {
            setNormalThumb()
        }
    }
    
    func holdSelectButton() {
        let settingsView = SettingsController()
        self.navigationController?.pushViewController(settingsView, animated: true)
    }
    
    func setLargeThumb() {
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold)
        let thumbImage = UIImage(systemName: "circle.fill", withConfiguration: config)?.withTintColor(UIColor.systemBlue, renderingMode: .alwaysOriginal)
        self.trackTime.setThumbImage(thumbImage, for: .normal)
    }
    
    func setNormalThumb() {
        let config = UIImage.SymbolConfiguration(pointSize: 6, weight: .bold)
        let thumbImage = UIImage(systemName: "circle.fill", withConfiguration: config)?.withTintColor(UIColor.label, renderingMode: .alwaysOriginal)
        self.trackTime.setThumbImage(thumbImage, for: .normal)
    }
}
