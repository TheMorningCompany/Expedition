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
    override func viewDidLoad() {
        super.viewDidLoad()

        print(historySwitch.isOn)
        
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
        
        //Make nav controller titlebar have no shadow and back button have no text
        
        self.navigationController!.navigationBar.layer.borderWidth = 0.50
        self.navigationController!.navigationBar.layer.borderColor = UIColor.clear.cgColor
        self.navigationController?.navigationBar.clipsToBounds = true
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
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
        ViewController().doTheDeleteCookies()
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
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
 

}
