//
//  Gestures.swift
//  Expedition
//
//  Created by Finbarr O'Connell on 12/16/19.
//  Copyright © 2019 The Morning Company. All rights reserved.
//
import WebKit
import UIKit
import Foundation

let impact = UIImpactFeedbackGenerator() // Haptics
let notification = UINotificationFeedbackGenerator()//Haptics


class Gestures : WKWebView, WKNavigationDelegate{
     @IBOutlet weak var webView: WKWebView!
     @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    
    @IBAction func back(_ sender: Any) { //makes the page go back if it can
        impact.impactOccurred() // Haptics
        if webView.canGoBack{
            webView.goBack()
            webView.reload()
        }
    }

    @IBAction func forward(_ sender: Any) { //makes the page go forward if it can
       impact.impactOccurred() // Haptics
        if webView.canGoForward{
            webView.goForward()
            webView.reload()
        }
    }

    @IBAction func reload(_ sender: Any) {
        //impact.impactOccurred() // Haptics
        notification.notificationOccurred(.success)//Haptics
        webView.reload()
        
    }
    

  
}
    

    

