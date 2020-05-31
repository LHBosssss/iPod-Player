//
//  SceneDelegate.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var iPodV = iPodView()
    var musicPlayer = MusicPlayer()
    var overlayView = UIView()
    var screenView = UIView()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        let navVC = UINavigationController(rootViewController: MenuController())
        window?.rootViewController = navVC
        
        // Create iPod Theme
        overlayView  = createOverlay(frame: window!.frame)
        window?.addSubview(overlayView)
        screenView = createScreenView(frame: window!.frame, border: UIColor.green)
        window?.addSubview(screenView)
        // Create Control UI
        window?.addSubview(iPodV)
        iPodV.topAnchor.constraint(equalTo: window!.centerYAnchor).isActive = true
        iPodV.bottomAnchor.constraint(equalTo: window!.bottomAnchor).isActive = true
        iPodV.leadingAnchor.constraint(equalTo: window!.leadingAnchor).isActive = true
        iPodV.trailingAnchor.constraint(equalTo: window!.trailingAnchor).isActive = true
    }

  
    func createOverlay(frame: CGRect) -> UIView {
        let overlayView = UIView(frame: frame)
        overlayView.backgroundColor = .black
//        overlayView.layer.borderWidth = 3
//        overlayView.layer.masksToBounds = true
//        overlayView.layer.cornerRadius = 39
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
    
    func createScreenView(frame: CGRect, border: UIColor) -> UIView {
        let screenView = UIView(frame: CGRect(x: 20, y: 50, width: frame.width - 40, height: frame.height/2 - 50))
        screenView.layer.masksToBounds = true
        screenView.layer.cornerRadius = 20
        screenView.backgroundColor = UIColor.clear
        screenView.layer.borderColor = border.cgColor
        screenView.layer.borderWidth = 5
        return screenView
    }
    
    func changeTheme(color: ColorModel) {
        overlayView.backgroundColor = color.bgColor
        screenView.layer.borderColor = color.borderColor.cgColor
        iPodV.setControlColor(color: color)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

