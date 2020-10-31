//
//  TabsMainViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 10/30/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class TabsMainViewController: UIViewController {

    @IBOutlet weak var newTabBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.newTabBtn.layer.cornerRadius = 20.0
        self.newTabBtn.layer.cornerCurve = .continuous
        
    }
    


}
