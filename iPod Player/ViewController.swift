//
//  ViewController.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    private let menuTable: UITableView = {
        let menu = UITableView()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        return menu
    }()
    
    let menu = ["Now Playing", "Songs", "Playlists", "Albums", "Artists", "Shuffle", "Settings"]
    var currentRow = 0
    // SUPER VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = true
        
        setupMenuView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.iPodV.selectButton.addTarget(self, action: #selector(handleSelectButton), for: .touchUpInside)
        sceneDelegate.iPodV.forwardButton.addTarget(self, action: #selector(handleForwardButton), for: .touchUpInside)
        sceneDelegate.iPodV.backwardButton.addTarget(self, action: #selector(handleBackwardButton), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.iPodV.selectButton.removeTarget(nil, action: nil, for: .allEvents)
        sceneDelegate.iPodV.forwardButton.removeTarget(nil, action: nil, for: .allEvents)
        sceneDelegate.iPodV.backwardButton.removeTarget(nil, action: nil, for: .allEvents)

    }
    
    func setupMenuView() {
        menuTable.delegate = self
        menuTable.dataSource = self
        view.addSubview(menuTable)
        menuTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        menuTable.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        menuTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        menuTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        menuTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
    }
    
    @objc func handleSelectButton() {
        print("handleNextButton")
        let nextView = SecondViewController()
        self.navigationController?.pushViewController(nextView, animated: true)
       }
    
    @objc func handleForwardButton() {
        currentRow += 1
        menuTable.selectRow(at: IndexPath(row: min(menu.count - 1, currentRow), section: 0), animated: true, scrollPosition: .middle)
    }
    
    @objc func handleBackwardButton() {
     currentRow -= 1
     menuTable.selectRow(at: IndexPath(row: max(0, currentRow), section: 0), animated: true, scrollPosition: .middle)
    }
}

extension MainMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        return cell
    }
}

extension MainMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.gray
    }
}
