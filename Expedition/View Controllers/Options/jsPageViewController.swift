//
//  jsPageViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 12/5/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class jsPageViewController: UITableViewController {

    @IBOutlet weak var jsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func reopenTabsSwitchValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(jsSwitch.isOn, forKey: "js")
        UserDefaults.standard.synchronize()
    }
    @objc func defaultsChanged(){
        let javascript = UserDefaults.standard.bool(forKey: "js")
        if (javascript) {
            jsSwitch.setOn(javascript, animated: false)
        }
    }
    
       
}
