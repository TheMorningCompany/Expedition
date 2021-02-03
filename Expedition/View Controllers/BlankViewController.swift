//
//  BlankViewController.swift
//  Expedition
//
//  Created by Julian Wright on 1/28/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class BlankViewController: UIViewController {
    
    @IBOutlet weak var icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        icon.layer.cornerCurve = .continuous
//        icon.layer.cornerRadius = 35
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func appMovedToForeground() {
        performSegue(withIdentifier: "showSearchScreen", sender: self)
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
