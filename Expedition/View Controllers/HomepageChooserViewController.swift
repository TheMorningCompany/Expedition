//
//  HomepageChooserViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 1/30/21.
//  Copyright © 2021 The Morning Company. All rights reserved.
//

import UIKit

class HomepageChooserViewController: UITableViewController {

    @IBOutlet weak var customUrlChooser: UITextField!
    
    let homepage = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let homepageToLoad = UserDefaults.standard.string(forKey: "homepage")
        customUrlChooser.text = homepageToLoad
    }
    @IBAction func expedition(_ sender: Any) {
        UserDefaults.standard.set("expedition", forKey: "homepage")
    }
    @IBAction func ddg(_ sender: Any) {
        UserDefaults.standard.set("ddg", forKey: "homepage")
    }
    @IBAction func empty(_ sender: Any) {
        UserDefaults.standard.set("empty", forKey: "homepage")
    }
    @IBAction func custom(_ sender: Any) {
        if customUrlChooser.text != nil {
            let customUrl = customUrlChooser.text
            UserDefaults.standard.set(customUrl, forKey: "homepage")
        }
    }
    

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
