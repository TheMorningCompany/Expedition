//
//  IntroViewController.swift
//  Expedition
//
//  Created by Julian Wright on 1/19/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var gifView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("LOADED INTRO VIEW CONTROLLER")
        
//        OptionsViewController().registerSettingsBundle()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alreadyOpened = UserDefaults.standard.bool(forKey: "has_opened")
        
        if alreadyOpened {
            switchToSearchView()
            
        } else {
            UserDefaults.standard.set(true, forKey: "has_opened")
            gifView.loadGif(name: "LightIntro")
            let timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.switchToSearchView), userInfo: nil, repeats: false)
            
        }
    }
    
    @objc func switchToSearchView() {
        performSegue(withIdentifier: "showSearchView", sender: self)
    }
    
    @objc func switchToHowToUseView() {
    performSegue(withIdentifier: "goToHowToUse", sender: nil)
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
