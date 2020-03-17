//
//  Onb1ViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 3/16/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class Onb1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "customToPrivacy", sender: self)
    }
    
   
}
