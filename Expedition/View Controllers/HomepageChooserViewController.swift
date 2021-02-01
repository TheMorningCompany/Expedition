//
//  HomepageChooserViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 1/30/21.
//  Copyright © 2021 The Morning Company. All rights reserved.
//

import UIKit

class HomepageChooserViewController: UITableViewController {

    let notification = UINotificationFeedbackGenerator()//Haptics
    let impact = UIImpactFeedbackGenerator() // Haptics
    
    @IBOutlet weak var customUrlChooser: UITextField!
    
    @IBOutlet weak var expeditionImg: AppIconPickerImageView!
    @IBOutlet weak var ddgImg: AppIconPickerImageView!
    @IBOutlet weak var emptyImg: AppIconPickerImageView!
    @IBOutlet weak var customImg: AppIconPickerImageView!
    
    
    let homepage = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let homepageToLoad = UserDefaults.standard.string(forKey: "homepage")
        if !homepageToLoad!.contains("empty") && !homepageToLoad!.contains("ddg") && !homepageToLoad!.contains("expedition") {
            self.customUrlChooser.text = homepageToLoad
        } else {
            self.customUrlChooser.text = ""
        }
        
        //Add outline to selected one
        if homepageToLoad!.contains("empty") {
            emptyImg.layer.borderWidth = 2
            emptyImg.layer.borderColor = UIColor(named: "Expedition Blue")?.cgColor
            ddgImg.layer.borderWidth = 0
            expeditionImg.layer.borderWidth = 0
            customImg.layer.borderWidth = 0
        }
        if homepageToLoad!.contains("expedition") {
            expeditionImg.layer.borderColor = UIColor(named: "Expedition Blue")?.cgColor
            expeditionImg.layer.borderWidth = 2
            ddgImg.layer.borderWidth = 0
            emptyImg.layer.borderWidth = 0
            customImg.layer.borderWidth = 0
        }
        if homepageToLoad!.contains("custom") {
            customImg.layer.borderWidth = 2
            customImg.layer.borderColor = UIColor(named: "Expedition Blue")?.cgColor
            ddgImg.layer.borderWidth = 0
            emptyImg.layer.borderWidth = 0
            expeditionImg.layer.borderWidth = 0
        }
        if homepageToLoad!.contains("ddg") {
            ddgImg.layer.borderWidth = 2
            ddgImg.layer.borderColor = UIColor(named: "Expedition Blue")?.cgColor
            expeditionImg.layer.borderWidth = 0
            emptyImg.layer.borderWidth = 0
            customImg.layer.borderWidth = 0
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
    }
    @IBAction func expedition(_ sender: Any) {
        UserDefaults.standard.set("expedition", forKey: "homepage")
        impact.impactOccurred() // Haptics
        
        
        expeditionImg.layer.borderColor = UIColor(named: "Expedition Blue")?.cgColor
        
            self.expeditionImg.layer.borderWidth = 2
            self.ddgImg.layer.borderWidth = 0
            self.emptyImg.layer.borderWidth = 0
            self.customImg.layer.borderWidth = 0
        
    }
    @IBAction func ddg(_ sender: Any) {
        UserDefaults.standard.set("ddg", forKey: "homepage")
        impact.impactOccurred() // Haptics
        
        ddgImg.layer.borderWidth = 2
        ddgImg.layer.borderColor = UIColor(named: "Expedition Blue")?.cgColor
        expeditionImg.layer.borderWidth = 0
        emptyImg.layer.borderWidth = 0
        customImg.layer.borderWidth = 0
    }
    @IBAction func empty(_ sender: Any) {
        UserDefaults.standard.set("empty", forKey: "homepage")
        impact.impactOccurred() // Haptics
        
        emptyImg.layer.borderWidth = 2
        emptyImg.layer.borderColor = UIColor(named: "Expedition Blue")?.cgColor
        ddgImg.layer.borderWidth = 0
        expeditionImg.layer.borderWidth = 0
        customImg.layer.borderWidth = 0
    }
    @IBAction func custom(_ sender: Any) {
        if customUrlChooser.text != nil {
            let customUrl = customUrlChooser.text
            UserDefaults.standard.set(customUrl, forKey: "homepage")
            impact.impactOccurred() // Haptics
        }
        
        customImg.layer.borderWidth = 2
        customImg.layer.borderColor = UIColor(named: "Expedition Blue")?.cgColor
        ddgImg.layer.borderWidth = 0
        emptyImg.layer.borderWidth = 0
        expeditionImg.layer.borderWidth = 0
    }
    
    @IBAction func urlFieldTouched(_ sender: Any) {
        impact.impactOccurred() // Haptics
        customUrlChooser.text = "https://"
        customImg.layer.borderWidth = 2
        customImg.layer.borderColor = UIColor(named: "Expedition Blue")?.cgColor
        ddgImg.layer.borderWidth = 0
        emptyImg.layer.borderWidth = 0
        expeditionImg.layer.borderWidth = 0
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        customUrlChooser.endEditing(true)
        customUrlChooser.resignFirstResponder()
    }
    @IBAction func doneEditingCustomUrl(_ sender: Any) {
            let customUrl = customUrlChooser.text
            UserDefaults.standard.set(customUrl, forKey: "homepage")
    }
    @IBAction func tappedReturn(_ sender: Any) {
        customUrlChooser.endEditing(true)
        customUrlChooser.resignFirstResponder()
        let customUrl = customUrlChooser.text
        UserDefaults.standard.set(customUrl, forKey: "homepage")
        
        customImg.layer.borderWidth = 2
        customImg.layer.borderColor = UIColor(named: "Expedition Blue")?.cgColor
        ddgImg.layer.borderWidth = 0
        emptyImg.layer.borderWidth = 0
        expeditionImg.layer.borderWidth = 0
    }
    
    
    
    
    
    
    
    
    
    
}
