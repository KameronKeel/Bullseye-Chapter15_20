//
//  HighScoresViewController.swift
//  Bullseye2
//
//  Created by Kameron Keel on 9/6/20.
//  Copyright © 2020 Kameron Keel. All rights reserved.
//

import UIKit

class HighScoresViewController: UITableViewController, EditHighScoreViewControllerDelegate {
    var items = [HighScoreItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        items = PersistencyHelper.loadHighScores()
        if (items.count == 0){
       resetHighScore()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreItem", for: indexPath)
        
        let item = items[indexPath.row]
        
        let nameLabel = cell.viewWithTag(1000) as! UILabel
        let scoreLabel = cell.viewWithTag(2000) as! UILabel
        
        nameLabel.text = item.name
        scoreLabel.text = String(item.score)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        PersistencyHelper.saveHighScores(items)
    }
    
    @IBAction func resetHighScore(){
        let item1 = HighScoreItem()
               item1.name = "The reader of this book"
               item1.score = 50000
               items.append(item1)
               
               let item2 = HighScoreItem()
               item2.name = "Manda"
               item2.score = 10000
               items.append(item2)
               
               let item3 = HighScoreItem()
               item3.name = "Joey"
               item3.score = 5000
               items.append(item3)
               
               let item4 = HighScoreItem()
               item4.name = "Adam"
               item4.score = 1000
               items.append(item4)
               
               let item5 = HighScoreItem()
               item5.name = "Eli"
               item5.score = 500
               items.append(item5)
        tableView.reloadData()
        PersistencyHelper.saveHighScores(items)
    }
    
    func editHighScoreViewControllerDidCancel(
                           _ controller:
    EditHighScoreViewController) {
    navigationController?.popViewController(animated:true)
    }
    func editHighScoreViewController(
    _ controller: EditHighScoreViewController,
    didFinishEditing item: HighScoreItem) {
        if let index = items.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            let indexPaths = [indexPath]
            
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }
        PersistencyHelper.saveHighScores(items)
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let controller = segue.destination as! EditHighScoreViewController
        controller.delegate = self
        if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
            controller.highScoreItem = items[indexPath.row]
        }
    }
    
   
    }
