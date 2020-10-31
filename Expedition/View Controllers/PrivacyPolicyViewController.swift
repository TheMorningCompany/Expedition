//
//  PrivacyPolicyViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 10/30/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    @IBOutlet weak var textBG: UIView!
    @IBOutlet weak var gradientTitle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textBG.layer.cornerRadius = 20.0
        self.textBG.layer.cornerCurve = .continuous
        
        self.gradientTitle.layer.cornerRadius = 20.0
        self.gradientTitle.layer.cornerCurve = .continuous
        
        
        gradientTitle.layer.masksToBounds = true
    }
    
}
