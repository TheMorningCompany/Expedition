//
//  AppIconsViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 3/22/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class AppIconsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func didTapLightIcon(_ sender: UIButton) {
        impact.impactOccurred() // Haptics
        UIApplication.shared.setAlternateIconName("lightblueicon")
    }
    
    @IBAction func didTapDarkIcon(_ sender: UIButton) {
       impact.impactOccurred() // Haptics
        UIApplication.shared.setAlternateIconName("darkicon")
    }
    
    @IBAction func didTapGlyphIcon(_ sender: UIButton) {
     impact.impactOccurred() // Haptics
        UIApplication.shared.setAlternateIconName("glyphicon")
    }
    
    @IBAction func didTapShadowIcon(_ sender: UIButton) {
      impact.impactOccurred() // Haptics
        UIApplication.shared.setAlternateIconName("shadow")
    }
    
    @IBAction func didTapFadingIcon(_ sender: UIButton) {
       impact.impactOccurred() // Haptics
        UIApplication.shared.setAlternateIconName("fadingicon")
    }
    
    @IBAction func didTapLightBlueIcon(_ sender: Any) {
       impact.impactOccurred() // Haptics
        UIApplication.shared.setAlternateIconName(nil)
    }

}
