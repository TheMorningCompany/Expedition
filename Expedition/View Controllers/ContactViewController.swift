//
//  ContactViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 5/1/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func youtubeOpen(_ sender: Any) {
    }
    @IBAction func instagramOpen(_ sender: Any) {
    }
    @IBAction func githubOpen(_ sender: Any) {
    }
    @IBAction func emailOpen(_ sender: Any) {
        //Doesn't work in Simulator
        showMailComposer()
    }
    
    func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            //Show alert
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["tmcdevelopmentteam@gmail.com"])
        composer.setSubject("Expedition Support")
        composer.setMessageBody("", isHTML: false)
        
        present(composer, animated: true)
        
        
    }

}
extension ContactViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       
        if let _ = error {
            //show error alert
            controller.dismiss(animated: true)
        }
        switch result {
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        case .saved:
        print("saved")
        case .sent:
              print("sent")
        }
        controller.dismiss(animated: true)
    }
}
