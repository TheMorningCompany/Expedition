//
//  FadeOnCloseViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 12/5/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class FadeOnCloseViewController: UITableViewController {

    @IBOutlet weak var fadeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                registerSettingsBundle()
                NotificationCenter.default.addObserver(self, selector: #selector(defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
                defaultsChanged()
    }
    @objc func appMovedToBackground() {
        let fadeOnClose = UserDefaults.standard.bool(forKey: "fade_on_close")
        if (fadeOnClose) {
            performSegue(withIdentifier: "showBlankScreen", sender: self)
        }
    }
    @IBAction func fadeSwitchValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(fadeSwitch.isOn, forKey: "reopen_tabs")
        UserDefaults.standard.synchronize()
    }
    @objc func defaultsChanged(){
        let fadeOnClose = UserDefaults.standard.bool(forKey: "fade_on_close")
        if (fadeOnClose) {
            fadeSwitch.setOn(fadeOnClose, animated: false)
        }
    }
    func registerSettingsBundle(){
            let appDefaults = [String:AnyObject]()
            UserDefaults.standard.register(defaults: appDefaults)
        }
    
       
}
