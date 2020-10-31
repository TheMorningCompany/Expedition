//
//  TabsTableViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 3/22/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class TabsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
               //delete tab from memory
               do {
                   
                   completion(true)
               } catch {
                   print("delete failed: \(error)")
                   completion(false)
               }
               
           }
           action.image = #imageLiteral(resourceName: "closeTab")
           action.backgroundColor = UIColor(named: "Elevated")
           return UISwipeActionsConfiguration(actions: [action])
           
       }
    
    

}
