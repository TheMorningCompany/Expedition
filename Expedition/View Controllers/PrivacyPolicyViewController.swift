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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textBG.layer.cornerRadius = 20.0
        self.textBG.layer.cornerCurve = .continuous
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
