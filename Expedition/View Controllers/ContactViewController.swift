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

    @IBOutlet weak var cellBGYT: UIView!
    @IBOutlet weak var ytImage: UIView!
    @IBOutlet weak var igImage: UIView!
    @IBOutlet weak var cellBGIG: UIView!
    @IBOutlet weak var ghImage: UIView!
    @IBOutlet weak var mailImage: UIView!
    @IBOutlet weak var cellBGGH: UIView!
    @IBOutlet weak var cellBGEmail: UIView!
    @IBOutlet weak var titleCellBG: UIView!
    @IBOutlet weak var cellBGtwitter: UIView!
    @IBOutlet weak var cellBGreddit: UIView!
    @IBOutlet weak var redditImage: UIView!
    @IBOutlet weak var twitterImage: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Cell Radius
        self.cellBGYT.layer.cornerRadius = 20.0
        self.cellBGYT.layer.cornerCurve = .continuous
        self.cellBGIG.layer.cornerRadius = 20.0
        self.cellBGIG.layer.cornerCurve = .continuous
        self.cellBGGH.layer.cornerRadius = 20.0
        self.cellBGGH.layer.cornerCurve = .continuous
        self.cellBGEmail.layer.cornerRadius = 20.0
        self.cellBGEmail.layer.cornerCurve = .continuous
        self.titleCellBG.layer.cornerRadius = 20.0
        self.titleCellBG.layer.cornerCurve = .continuous
        self.cellBGreddit.layer.cornerRadius = 20.0
        self.cellBGreddit.layer.cornerCurve = .continuous
        self.cellBGtwitter.layer.cornerRadius = 20.0
        self.cellBGtwitter.layer.cornerCurve = .continuous
        
        //Icon Radius
        self.ytImage.layer.cornerRadius = 14.0
        self.ytImage.layer.cornerCurve = .continuous
        self.igImage.layer.cornerRadius = 14.0
        self.igImage.layer.cornerCurve = .continuous
        self.ghImage.layer.cornerRadius = 14.0
        self.ghImage.layer.cornerCurve = .continuous
        self.mailImage.layer.cornerRadius = 14.0
        self.mailImage.layer.cornerCurve = .continuous
        self.redditImage.layer.cornerRadius = 14.0
        self.redditImage.layer.cornerCurve = .continuous
        self.twitterImage.layer.cornerRadius = 14.0
        self.twitterImage.layer.cornerCurve = .continuous

    }
    
    @IBAction func youtubeOpen(_ sender: Any) {
        dismiss(animated: true)
        openYT()
    }
    @IBAction func instagramOpen(_ sender: Any) {
        dismiss(animated: true)
        openTheInstagramPage()
        
    }
    @IBAction func githubOpen(_ sender: Any) {
        dismiss(animated: true)
        openGithub()
        
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
    
    func openTheInstagramPage() {
        
        openIG()
        dismiss(animated: true, completion: nil)
        //This needs to be changed to open the url in expedition itself if the app isn't installed
//        guard let instagram = URL(string: "https://www.instagram.com/themorningcompanymedia") else { return }
//           UIApplication.shared.open(instagram)
        
    }
    
    func openGithub() {
        NotificationCenter.default.post(name: OPEN_GITHUB, object: "https://github.com/orgs/TheMorningCompany/teams" )
        
    }
    
    func openYT() {
        NotificationCenter.default.post(name: OPEN_YT, object: "https://youtube.com/themorningcompanytv" )
        
    }
    
    func openIG() {
        NotificationCenter.default.post(name: OPEN_IG, object: "https://www.instagram.com/themorningcompanymedia" )
        
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
        @unknown default:
            print("unknown")
        }
        controller.dismiss(animated: true)
    }
}
