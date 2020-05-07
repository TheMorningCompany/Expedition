//
//  Onb1ViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 3/16/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class Onb1ViewController: UITableViewController {
    @IBOutlet weak var fadeOnCloseSwitch: UISwitch!
    @IBOutlet weak var showToolbarSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        optionsChanged()
    }
    
    func optionsChanged() {
        UserDefaults.standard.set(fadeOnCloseSwitch.isOn, forKey: "fade_on_close")
        UserDefaults.standard.set(showToolbarSwitch.isOn, forKey: "show_toolbar")
        UserDefaults.standard.synchronize()
    }
}
