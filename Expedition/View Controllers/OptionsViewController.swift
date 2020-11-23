//
//  OptionsViewController.swift
//  Expedition
//
//  Created by Julian Wright on 1/7/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import CoreData

class OptionsViewController: UITableViewController {
    let notification = UINotificationFeedbackGenerator()//Haptics
    let impact = UIImpactFeedbackGenerator() // Haptics
    @IBOutlet weak var historySwitch: UISwitch!
    @IBOutlet weak var keepCookiesSwitch: UISwitch!
    @IBOutlet weak var reopenTabsSwitch: UISwitch!
    @IBOutlet weak var fadeOnCloseSwitch: UISwitch!
    @IBOutlet weak var titleBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleBar.layer.cornerRadius = 20.0
        self.titleBar.layer.cornerCurve = .continuous
        self.titleBar.clipsToBounds = true
//        print(historySwitch.isOn)
//
//        registerSettingsBundle()
//        NotificationCenter.default.addObserver(self, selector: #selector(defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
//        defaultsChanged()
//
//        //Make nav controller titlebar have no shadow and back button have no text
//
//        self.navigationController!.navigationBar.layer.borderWidth = 0.50
//        self.navigationController!.navigationBar.layer.borderColor = UIColor.clear.cgColor
//        self.navigationController?.navigationBar.clipsToBounds = true
//        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backBarButtton
    }
    
//    @IBAction func didTapHowToUse(_ sender: UIButton) {
//        impact.impactOccurred() // Haptics
//        //present(, animated: true)
//    }
//
//
//
//    @IBAction func historySwitchValueChange(_ sender: Any) {
//        UserDefaults.standard.set(historySwitch.isOn, forKey: "save_history")
//        UserDefaults.standard.synchronize()
//    }
//
//    @IBAction func cookiesSwitchValueChange(_ sender: UISwitch) {
//        UserDefaults.standard.set(keepCookiesSwitch.isOn, forKey: "keep_cookies")
//        UserDefaults.standard.synchronize()
//    }
//    @IBAction func reopenTabsSwitchValueChanged(_ sender: UISwitch) {
//        UserDefaults.standard.set(reopenTabsSwitch.isOn, forKey: "reopen_tabs")
//        UserDefaults.standard.synchronize()
//    }
//    @IBAction func fadeSwitchValueChanged(_ sender: UISwitch) {
//        UserDefaults.standard.set(fadeOnCloseSwitch.isOn, forKey: "fade_on_close")
//        UserDefaults.standard.synchronize()
//    }
//
//    func registerSettingsBundle(){
//        let appDefaults = [String:AnyObject]()
//        UserDefaults.standard.register(defaults: appDefaults)
//    }
//
////    @objc func appMovedToBackground() {
////        let fadeOnClose = UserDefaults.standard.bool(forKey: "fade_on_close")
////        if (fadeOnClose) {
////            performSegue(withIdentifier: "showBlankScreen", sender: self)
////        }
////    }
//
//    @objc func defaultsChanged(){
//        let saveHistory = UserDefaults.standard.bool(forKey: "save_history")
//        if (saveHistory) {
//            historySwitch.setOn(saveHistory, animated: false)
//        }
//
//        let keepCookies = UserDefaults.standard.bool(forKey: "keep_cookies")
//        if (keepCookies) {
//            keepCookiesSwitch.setOn(keepCookies, animated: false)
//        }
//        let reopenTabs = UserDefaults.standard.bool(forKey: "reopen_tabs")
//        if (reopenTabs) {
//            reopenTabsSwitch.setOn(reopenTabs, animated: false)
//        }
//        let fadeOnClose = UserDefaults.standard.bool(forKey: "fade_on_close")
//        if (fadeOnClose) {
//            fadeOnCloseSwitch.setOn(fadeOnClose, animated: false)
//        }
//    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
 

}
