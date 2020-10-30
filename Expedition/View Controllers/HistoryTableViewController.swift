//
//  HistoryTableViewController.swift
//  Expedition
//
//  Created by Julian Wright on 1/7/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import CoreData

class HistoryTableViewController: UITableViewController {
    let notification = UINotificationFeedbackGenerator()//Haptics
    let impact = UIImpactFeedbackGenerator() // Haptics
    @IBOutlet weak var historyTableView: UITableView!
    
    var historyArray = [HistoryElement]()
    
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let fetchRequest: NSFetchRequest<HistoryElement> = HistoryElement.fetchRequest()
        
        do {
            let historyArray = try PersistenceService.context.fetch(fetchRequest)
            self.historyArray = historyArray
            self.tableView.reloadData()
        } catch {
            print("ERROR OCCURRED")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historyArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
        
        //let cell = historyTableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        // Configure the cell...

        let row = indexPath.row
        cell.textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: UIFont.labelFontSize)
        cell.detailTextLabel?.font = UIFont(name: "AvenirNext-medium", size: 12)
        cell.textLabel?.text = historyArray[row].title
        cell.detailTextLabel?.text = historyArray[row].url
        cell.backgroundColor? = UIColor(named: "Expedition White")!
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        ViewController().openHistoryUrl(index: indexPath.row)
    }
   
    
    //Delete rows
   override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            
            do {
                
                completion(true)
            } catch {
                print("delete failed: \(error)")
                completion(false)
            }
            
        }
        action.image = #imageLiteral(resourceName: "trash")
        action.backgroundColor = UIColor(named: "Elevated")
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    //Open with swipe
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let action = UIContextualAction(style: .destructive, title: "Open") { (action, view, completion) in
             
             
             do {
                 ViewController().openHistoryUrl(index: indexPath.row)
                
                 completion(true)
             } catch {
                 print("opening url from history failed ERROR: \(error)")
                 completion(false)
             }
             
         }
         action.image = #imageLiteral(resourceName: "search")
         action.backgroundColor = UIColor(named: "Expedition White")
         return UISwipeActionsConfiguration(actions: [action])
         
     }
    @IBAction func clearBrowsingData(_ sender: UIButton) {
        impact.impactOccurred() // Haptics
        let alert = UIAlertController(title: "Clear Browsing Data", message: "Are you sure you want to clear cookies and history?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { action in
            self.doTheClearHistory()
            self.removeCookies()
            self.notification.notificationOccurred(.success)//Haptics
        }))

        self.present(alert, animated: true)
    }
    
    func removeCookies(){
        // Remove all cache
        ViewController().doTheDeleteCookies()
    }
    
    func doTheClearHistory() {
        HistoryTableViewController().historyArray = [HistoryElement]()
        let fetchRequest: NSFetchRequest<HistoryElement> = HistoryElement.fetchRequest()
        if let result = try? PersistenceService.context.fetch(fetchRequest) {
           for object in result {
               PersistenceService.context.delete(object)
           }
           PersistenceService.saveContext()
           HistoryTableViewController().tableView.reloadData()
        }
        print("history cleared", HistoryTableViewController().historyArray)
    }
    

}
