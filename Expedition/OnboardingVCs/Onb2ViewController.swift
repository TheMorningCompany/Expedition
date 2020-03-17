//
//  Onb2ViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 3/16/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class Onb2ViewController: UIViewController {
    @IBOutlet weak var historySwitch: UISwitch!
    @IBOutlet weak var keepCookiesSwitch: UISwitch!
    @IBOutlet weak var reopenTabsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsChanged()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "PrivacyToGesture", sender: self)
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        optionsChanged()
    }
    
    func optionsChanged() {
        UserDefaults.standard.set(historySwitch.isOn, forKey: "save_history")
        UserDefaults.standard.set(keepCookiesSwitch.isOn, forKey: "keep_cookies")
        UserDefaults.standard.set(reopenTabsSwitch.isOn, forKey: "reopen_tabs")
        UserDefaults.standard.synchronize()
    }
}
