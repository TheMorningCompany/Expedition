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
    @IBOutlet weak var showToolbarSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(historySwitch.isOn)
        
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapHowToUse(_ sender: UIButton) {
        impact.impactOccurred() // Haptics
        //present(, animated: true)
    }
    
    @IBAction func clearHistory(_ sender: UIButton) {
        impact.impactOccurred() // Haptics
        let alert = UIAlertController(title: "Clear History", message: "Are you sure you want to clear history?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { action in
          
            self.doTheClearHistory()
            self.notification.notificationOccurred(.success)//Haptics
        }))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func clearBrowsingData(_ sender: UIButton) {
        impact.impactOccurred() // Haptics
        let alert = UIAlertController(title: "Clear Browsing Data", message: "Are you sure you want to clear cookies and history?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { action in
            self.doTheClearHistory()
            self.removeCookies()
            self.notification.notificationOccurred(.success)//Haptics
        }))

        self.present(alert, animated: true)
    }
    
    func removeCookies(){
        // Remove all cache
        URLCache.shared.removeAllCachedResponses()

        // Delete any associated cookies
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                print("COOKIE: " + cookie.name)
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
    
    func doTheClearHistory() {
        HistoryTableViewController().historyArray = [HistoryElement]()
        let fetchRequest: NSFetchRequest<HistoryElement> = HistoryElement.fetchRequest()
        if let result = try? PersistenceService.context.fetch(fetchRequest) {
           for object in result {
               PersistenceService.context.delete(object)
           }
           PersistenceService.saveContext()
           HistoryTableViewController().tableView.reloadData()
        }
        print("history cleared", HistoryTableViewController().historyArray)
    }
    
    @IBAction func historySwitchValueChange(_ sender: Any) {
        UserDefaults.standard.set(historySwitch.isOn, forKey: "save_history")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func cookiesSwitchValueChange(_ sender: UISwitch) {
        UserDefaults.standard.set(keepCookiesSwitch.isOn, forKey: "keep_cookies")
        UserDefaults.standard.synchronize()
    }
    @IBAction func reopenTabsSwitchValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(reopenTabsSwitch.isOn, forKey: "reopen_tabs")
        UserDefaults.standard.synchronize()
    }
    @IBAction func fadeSwitchValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(fadeOnCloseSwitch.isOn, forKey: "fade_on_close")
        UserDefaults.standard.synchronize()
    }
    @IBAction func toolbarSwitchValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(showToolbarSwitch.isOn, forKey: "show_toolbar")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toolbar"), object: nil)
    }
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    @objc func defaultsChanged(){
        if let saveHistory:Bool = UserDefaults.standard.bool(forKey: "save_history") {
            historySwitch.setOn(saveHistory, animated: false)
        }
        if let keepCookies:Bool = UserDefaults.standard.bool(forKey: "keep_cookies") {
            keepCookiesSwitch.setOn(keepCookies, animated: false)
        }
        if let reopenTabs:Bool = UserDefaults.standard.bool(forKey: "reopen_tabs") {
            reopenTabsSwitch.setOn(reopenTabs, animated: false)
        }
        if let fadeOnClose:Bool = UserDefaults.standard.bool(forKey: "fade_on_close") {
            fadeOnCloseSwitch.setOn(fadeOnClose, animated: false)
        }
        if let showToolbar:Bool = UserDefaults.standard.bool(forKey: "show_toolbar") {
            showToolbarSwitch.setOn(showToolbar, animated: false)
        }
    }
    
    
 

}
