//
//  Playlists.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/27/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import MediaPlayer

class PlaylistsController: UIViewController {
    
    private let playlistsTable: UITableView = {
        let playlists = UITableView()
        playlists.translatesAutoresizingMaskIntoConstraints = false
        playlists.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        playlists.rowHeight = 50
        return playlists
    }()
    
    private var listPlaylists = [PlaylistModel]()
    private var currentRow = 0
    
    // SUPER VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = true
        setupPlaylistsTable()
        getPlaylists()
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
    
    func setupPlaylistsTable() {
        self.view.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height / 2 - 50)
        playlistsTable.delegate = self
        playlistsTable.dataSource = self
        view.addSubview(playlistsTable)
        playlistsTable.frame = view.frame
        print(playlistsTable.frame)
        print(self.view.frame)
    }
    
    func getPlaylists() {
        let playlists: [MPMediaPlaylist] = MPMediaQuery.playlists().collections! as! [MPMediaPlaylist]
        for item in playlists {
            let title = item.name ?? "Không có Tên"
            let num = item.count
            let model = PlaylistModel(title: title, songs: num)
            listPlaylists.append(model)
        }
        playlistsTable.reloadData()
        playlistsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)

    }
    
    @objc func handleForwardButton() {
        currentRow += 1
        currentRow = currentRow > listPlaylists.count - 1 ? listPlaylists.count - 1 : currentRow
        playlistsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
    }
    
    @objc func handleBackwardButton() {
        currentRow -= 1
        currentRow = currentRow < 0 ? 0 : currentRow
        playlistsTable.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
    }
}

extension PlaylistsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPlaylists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = listPlaylists[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print(cell)
        cell.selectionStyle = .gray
        cell.imageView?.image = model.image
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = "Detail"
        return cell
    }
    
    
}

extension PlaylistsController: UITableViewDelegate {
    
}
