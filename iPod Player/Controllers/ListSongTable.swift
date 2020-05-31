//
//  SubMenuTableViewController.swift
//  iPod Player
//
//  Created by Ho Duy Luong on 5/25/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit
import MediaPlayer

class ListSong: UITableViewController {
    
    var listSong = [SongModel]()
    var currentRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height / 2 - 50)
        tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
    }
    
    func setupTable() {
        tableView.register(MenuCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 50
        tableView.contentMode = .center
    }
    
    @objc func handleForwardButton() {
        currentRow += 1
        currentRow = currentRow > listSong.count - 1 ? listSong.count - 1 : currentRow
        tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
    }
    
    @objc func handleBackwardButton() {
        currentRow -= 1
        currentRow = currentRow < 0 ? 0 : currentRow
        tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: true, scrollPosition: .middle)
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listSong.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCell
        cell.cellModel = listSong[indexPath.row]
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }    
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
