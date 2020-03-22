//
//  Onb1ViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 3/16/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class Onb1ViewController: UIViewController {
    @IBOutlet weak var fadeOnCloseSwitch: UISwitch!
    @IBOutlet weak var showToolbarSwitch: UISwitch!
    @IBOutlet weak var titleImage: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var illustration: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsChanged()
        titleImage.alpha = 1
        titleLabel.alpha = 1
        illustration.alpha = 1
        titleImage.isHidden = false
        titleLabel.isHidden = false
        sleep(UInt32(0.5))
        UIView.animate(withDuration: 2) {
            self.titleImage.alpha = 0
            self.titleLabel.alpha = 0
            self.illustration.alpha = 0
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "customToPrivacy", sender: self)
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
