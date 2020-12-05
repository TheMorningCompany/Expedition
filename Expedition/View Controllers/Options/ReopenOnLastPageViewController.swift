//
//  ReopenOnLastPageViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 12/5/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class ReopenOnLastPageViewController: UITableViewController {

    @IBOutlet weak var reopenSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
        @IBAction func reopenTabsSwitchValueChanged(_ sender: UISwitch) {
            UserDefaults.standard.set(reopenSwitch.isOn, forKey: "reopen_tabs")
            UserDefaults.standard.synchronize()
        }
    
        @objc func defaultsChanged(){

            let reopenTabs = UserDefaults.standard.bool(forKey: "reopen_tabs")
            if (reopenTabs) {
                reopenSwitch.setOn(reopenTabs, animated: false)
            }

        }
}
