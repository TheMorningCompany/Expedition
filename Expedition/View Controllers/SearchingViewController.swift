//
//  ViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 8/16/19.
//  Copyright © 2019-2020 The Morning Company. All rights reserved.

import UIKit
import WebKit
import Foundation
import CoreData

class ViewController: UIViewController, WKNavigationDelegate, UISearchBarDelegate, UIScrollViewDelegate, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var accessibilityToolbar: UIToolbar!
    @IBOutlet weak var webViewTop: NSLayoutConstraint!
    @IBOutlet weak var toolbarBottom: NSLayoutConstraint!
    @IBOutlet weak var secureImg: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    let notification = UINotificationFeedbackGenerator()//Haptics
    @IBOutlet weak var menuLeft: NSLayoutConstraint!
    @IBOutlet weak var optionsRight: NSLayoutConstraint!
    @IBOutlet weak var sbarHeight: NSLayoutConstraint!
    @IBOutlet weak var sbarTop: NSLayoutConstraint!
    @IBOutlet weak var webviewRight: NSLayoutConstraint!
    @IBOutlet weak var webviewLeft: NSLayoutConstraint!
    
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var lastOffsetY :CGFloat = 0
    let impact = UIImpactFeedbackGenerator() // Haptics
    var userAgentVar: String = "mobile" //User agent
    let credits: String = "zeqe golomb:ui designer;finbarr oconnell:programmer;jackson yan:programmer;julian wright:programmer" //Credits
    var searchEngine: String = "https://start.duckduckgo.com/" //Search engine initialization
    var components = URLComponents(string: "https://start.duckduckgo.com/") //Search engine
    
    //constants
    let timeoutDelay = 5.0
    
    @IBOutlet weak var searchBar: UITextField!
    
    
    var homepageToLoad = UserDefaults.standard.string(forKey: "homepage")
    var homepageUrl = URL(string: "")
    
    override func viewDidLoad() { //Called when the app loads
        

        super.viewDidLoad()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont(name: "AvenirNext-Medium", size: UIFont.labelFontSize)
        var components = URLComponents(string: searchEngine)
       
        print("homepage is \(homepageToLoad!)")
        
        
        if homepageToLoad!.contains("expedition") {
//            homepageUrl = URL(string: "https://themorningcompany.net") //change this when homepage.html stuff is implemented
//            let request = URLRequest(url: homepageUrl!)
//            webView?.load(request)
            scrollUp()
            
        }
        if homepageToLoad!.contains("ddg") {
            homepageUrl = URL(string: "https://start.duckduckgo.com")
            let request = URLRequest(url: homepageUrl!)
            webView?.load(request)
        }
        if homepageToLoad!.contains("empty") {
//            homepageUrl = URL(string: "https://apple.com") //figure out about:blank
//            let request = URLRequest(url: homepageUrl!)
//            webView?.load(request)
            scrollUp()
        }
        if !homepageToLoad!.contains("empty") && !homepageToLoad!.contains("ddg") && !homepageToLoad!.contains("expedition") {
            if homepageToLoad == nil {
                homepageUrl = URL(string: "https://start.duckduckgo.com")
            } else {
                homepageUrl = URL(string: homepageToLoad!)
            }
            let request = URLRequest(url: homepageUrl!)
            webView?.load(request)
        }
        scrollUp()

        
        searchBar.layer.cornerRadius = 15
        searchBar.layer.cornerCurve = .continuous
        
        //MARK: SCROLLING STUFF
        webView.scrollView.delegate = self
        
        accessibilityToolbar.barTintColor = UIColor(named: "Expedition White")
        accessibilityToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
                
        webView.layer.cornerCurve = .continuous
        webView.layer.cornerRadius = 15
        webView.clipsToBounds = true
        
//        let request = URLRequest(url: url!)
        
        components?.scheme = "https"
        components?.host = "start.duckduckgo.com"
        
//        webView?.load(request)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/7.4 Expedition/605.1.15"
        } else {
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/5.2 Mobile/15E148 Expedition/604.1"
        }
        
        
        webView?.navigationDelegate = self
        
        
        if UserDefaults.standard.bool(forKey: "reopen_tabs") {
            let fetchRequest: NSFetchRequest<HistoryElement> = HistoryElement.fetchRequest()
            
            do {
                let historyArray = try
                    PersistenceService.context.fetch(fetchRequest)
                if historyArray.count > 0 {
                    openUrl(urlString: historyArray[0].url!)
                    print("OPEN: ", historyArray[0].url!)
                } else {
                    if !homepageToLoad!.contains("empty") && !homepageToLoad!.contains("expedition") {
                        openUrl(urlString: homepageUrl!.absoluteString)
                    }
                    if homepageToLoad!.contains("expedition") {
                        if let url = Bundle.main.url(forResource: "homepage", withExtension: "html") {
                            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
                            scrollUp()
                        }
                    }
                    if homepageToLoad!.contains("empty") {
                        if let url = Bundle.main.url(forResource: "empy", withExtension: "html") {
                            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
                            scrollUp()
                        }
                    }
                }
            } catch {
                print("ERROR OCCURRED")
            }
        } else {
            if homepageToLoad!.contains("expedition") {
                if let url = Bundle.main.url(forResource: "homepage", withExtension: "html") {
                    webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
                    scrollUp()
                }
            }
            if homepageToLoad!.contains("empty") {
                if let url = Bundle.main.url(forResource: "empy", withExtension: "html") {
                    webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
                    scrollUp()
                }
            }
            if !homepageToLoad!.contains("empty") && !homepageToLoad!.contains("expedition") {
                openUrl(urlString: homepageUrl!.absoluteString)
            }
        }
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        //MARK: Open urls from contact page
        NotificationCenter.default.addObserver(forName: OPEN_GITHUB, object: nil, queue: nil) { notification in
            let ghURL = URL(string: "https://github.com/TheMorningCompany")
            self.openUrl(urlString: ghURL!.absoluteString)
        }
        NotificationCenter.default.addObserver(forName: OPEN_YT, object: nil, queue: nil) { notification in
            let ytURL = URL(string: "https://youtube.com/themorningcompanytv")
            self.openUrl(urlString: ytURL!.absoluteString)
        }
        NotificationCenter.default.addObserver(forName: OPEN_IG, object: nil, queue: nil) { notification in
            let igURL = URL(string: "https://www.instagram.com/themorningcompanymedia")
            self.openUrl(urlString: igURL!.absoluteString)
        }
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: self.searchBar.frame.height))
        searchBar.leftView = paddingView
        searchBar.leftViewMode = UITextField.ViewMode.always
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    
    @objc func appMovedToBackground() {
        print("bg")
        let fadeOnClose = UserDefaults.standard.bool(forKey: "fade_on_close")
        if (fadeOnClose) {
//            performSegue(withIdentifier: "showBlankScreen", sender: self)
            UIView.animate(withDuration: 0.3) {
                self.webView.alpha = 0
                self.searchBar.alpha = 0
            }
        }
    }
    
    @objc func appMovedToForeground() {
        print("foreground")
        UIView.animate(withDuration: 0.3) {
            self.webView.alpha = 1
            self.searchBar.alpha = 1
        }
    }
    
    @IBAction func searchBarShare(_ sender: UILongPressGestureRecognizer) {
        impact.impactOccurred() // Haptic
        let textToShare = searchBar.text
        if textToShare != nil {
            displayShareSheet(shareContent: textToShare!)
        }
    }
    
    
    func schemeHandling(url: URL) {
        if url != nil {
            print("URL: " + url.absoluteString)
            if url.query != nil {
                let queryArray = url.query?.split(separator: "&")
                if queryArray != nil {
                    for query in queryArray! {
                        let queries = query.split(separator: "=")
                        if (queries[0] != nil && queries[1] != nil) {
                            if queries[0] == "url" {
                                openUrl(urlString: String(queries[1]))
                            }
                            if queries[0].lowercased() == "appicon" {
                                print("SHOULD CHANGE APP ICON")
                                UIApplication.shared.setAlternateIconName(String(queries[1]).lowercased())
                            }
                        }
                        print("URL", queries[0], queries[1])
                    }
                }
            } else {
                print("URL QUERY IS NIL")
            }
            
            if url.host != nil {
                let host = url.host
                print("URL HOST: " + host!)
                UIApplication.shared.setAlternateIconName(host!.lowercased())
            } else {
                print("URL HOST IS NIL")
            }
        } else {
            print("URL IS NIL")
        }
    }
    
    func displayShareSheet(shareContent:String) {
        notification.notificationOccurred(.success)//Haptic
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
    func displayShareSheet(shareContent:UIImage) {
        notification.notificationOccurred(.success) //Haptic
        let activityViewController = UIActivityViewController(activityItems: [shareContent], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: {})
    }
    
    func socialMedia(urlString: String) {
        let url = URL(string: urlString)

        let request = URLRequest(url: url!)
        print(request.url?.absoluteString as Any)

        webView?.load(request)

    }
    
    //MARK: MORE Scrolling
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0) {
            scrollUp()
        }
        else {
            scrollDown()
        }
    }
    func scrollDown() {
        self.webViewTop.constant = 50
        self.toolbarBottom.constant = 100
        self.sbarTop.constant = -100
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func scrollUp() {
        self.webViewTop.constant = 8
        self.toolbarBottom.constant = 0
        self.sbarTop.constant = 0
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        let js = UserDefaults.standard.bool(forKey: "js")
        if (js) {
            self.webView.configuration.preferences.javaScriptEnabled = true
        } else {
            self.webView.configuration.preferences.javaScriptEnabled = false
        }
        impact.impactOccurred() // Haptics
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.webView.customUserAgent = "Mozilla/5.0 (iPhone; like Mac OS X) AppleWebKit (KHTML, like Gecko) Version/7.4 Mobile/15E148 Expedition/604.1"
        } else {
            self.webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/7.4 Expedition/605.1.15"
            
        }
        progressView.isHidden = false
     }
    
     
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        impact.impactOccurred()//haptics

        progressView.isHidden = true
        if (!(webView.url?.absoluteString.starts(with: "file://"))!) {
            searchBar.text = webView.url?.absoluteString
        }
        
        if (UserDefaults.standard.bool(forKey: "save_history")) {
            let historyElementToAdd = HistoryElement(context: PersistenceService.context)
            historyElementToAdd.url = searchBar.text
            historyElementToAdd.title = webView.title
            PersistenceService.saveContext()
            HistoryTableViewController().historyArray.append(historyElementToAdd)
            HistoryTableViewController().tableView.reloadData()
//            if webView.hasOnlySecureContent {
//                secureImg.image = UIImage(named: "lockBlue")
//            } else {
//                secureImg.image = UIImage(named: "lockRed")
//            }
            
        }

     }
     
     func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         progressView.isHidden = true
         notification.notificationOccurred(.error)//Haptic
         standoutMessage(message: "FAILED NAVIGATION")
     }
    
    func openUrl(urlString: String) {
        if (verifyUrl(urlString: urlString)) {
            
            var url = URL(string: urlString)
            if (urlString.starts(with: "http://") || urlString.starts(with: "https://")) {
                print(urlString)
            } else {
                url = URL(string: "http://\(urlString)")
            }
            
            //searchBar.text = url?.absoluteString;
            
            let request = URLRequest(url: url!)
            
            webView?.load(request)
            
            standoutMessage(message: "VALID URL!")
        } else if (verifyUrl(urlString: urlToString(url: searchText(urlString: urlString)))) {
            let request = generateRequest(url: searchText(urlString: urlString))
            
            webView?.load(request)
            
            standoutMessage(message: "VALID SEARCH!")
           //MARK: Set lock image to be red or blue if its https encrypted

        } else {
            pageNotFound()
            
            standoutMessage(message: "PAGE NOT FOUND!")
        }
    }
    
    func openHistoryUrl(index: Int) {
        print(HistoryTableViewController().historyArray)
        
        let fetchRequest: NSFetchRequest<HistoryElement> = HistoryElement.fetchRequest()
        
        var historyArray = [HistoryElement]()
        
        do {
            historyArray = try PersistenceService.context.fetch(fetchRequest)
            let url = historyArray[index].url
            openUrl(urlString: url!)
            
        } catch {
            print("ERROR OCCURRED trying to open a history url")
        }
    }
    
    
    func searchText(urlString: String) -> URL { //creates the url for a query using duckduckgo
        let queryItemQuery = URLQueryItem(name: "q", value: urlString);
        
        components?.queryItems = [queryItemQuery]
        
        return (components?.url)!
    }
    
    
    


    @IBAction func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { //turns the users input into something that the search engine can use
        
        searchBar.resignFirstResponder()
        
        if (searchBar.text?.lowercased().starts(with: "expedition://"))! {
            print(searchBar.text!)
            let urlToHandle = URL(string: searchBar.text!)
            schemeHandling(url: urlToHandle!)
        } else {
            searchBar.text = searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            searchBar.text = searchBar.text!.lowercased()
            openUrl(urlString: searchBar.text!)
        }
        
    }

    @IBAction func reloadSwipe(_ sender: Any) {
        webView.reload()
    }

    @IBAction func desktopSiteSwipe(_ sender: Any) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            impact.impactOccurred()//haptic
       
            let response = switchUserAgent(agent: userAgentVar)
            
            userAgentVar = response[0]
            webView.customUserAgent = response[1]
        
            UIView.transition(with: searchBar, duration: 0.5, options: .transitionCrossDissolve, animations: { [weak self] in
                self?.searchBar.text = self?.userAgentVar
            }, completion: nil)
    
        }
    }
    
    // MARK: HANDLING PAGE ERRORS
    // such as timeouts and stuff
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        standoutMessage(message: "FAILED PROVISIONAL NAVIGATION")
        pageNotFound()
    }
    
    func pageNotFound() {
            if let url = Bundle.main.url(forResource: "NotFound", withExtension: "html") {
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
                 
            }
    
}
    
    //MARK: UTIL FUNCTIONS
    
    public func doTheDeleteCookies() {
        if #available(iOS 11, *) {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.httpCookieStore.getAllCookies({ (cookies) in
                for cookie in cookies {
                    dataStore.httpCookieStore.delete(cookie)
                }
            })
        } else {
            guard let cookies = HTTPCookieStorage.shared.cookies else {
                return
            }
            print(cookies)
        }
    }
    
    //MARK: BUTTONS
    
    @IBAction func backButton(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
        }
    
    }
    @IBAction func forwardButton(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
        
    }
    
    @IBAction func reloadButton(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func sbarTouched(_ sender: Any) {
        menuLeft.constant = -20
        optionsRight.constant = -20
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    @IBAction func sbardone(_ sender: Any) {
        menuLeft.constant = 10
        optionsRight.constant = 10
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    @IBAction func shareButton(_ sender: Any) {
//        let alert = UIAlertController(title: "what do you want to do", message: nil, preferredStyle: .actionSheet)
//
//            alert.addAction(UIAlertAction(title: "nothing", style: .cancel, handler: nil))
//
//            alert.addAction(UIAlertAction(title: "share url", style: .default, handler: { action in
//                self.displayShareSheet(shareContent: self.searchBar.text!)
//                self.impact.impactOccurred() //Haptics
//            }))
//
//            alert.addAction(UIAlertAction(title: "fullpage screenshot", style: .default, handler: { action in
//                let config = WKSnapshotConfiguration()
//                let pageHeight:CGFloat = self.webView.scrollView.contentSize.height
//                let pageWidth:CGFloat = self.webView.scrollView.contentSize.width
//
//    //            self.webView.evaluateJavaScript("document.body.offsetHeight", completionHandler: { (height, error) in
//    //                pageHeight = height
//    //            })
//    //
//    //            self.webView.evaluateJavaScript("document.body.offsetWidth", completionHandler: { (width, error) in
//    //                pageWidth = width
//    //            })
//
//                standoutMessage(message: "DIMENSIONS: \(pageWidth), \(pageHeight)")
//
//                config.rect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
//
//                self.webView.takeSnapshot(with: config) { image, error in
//                    if let image = image {
//                        print(image.size)
//                        self.displayShareSheet(shareContent: image)
//                    }
//                }
//            }))
//            
//            self.present(alert, animated: true)
        
        self.displayShareSheet(shareContent: self.searchBar.text!)
        }
    

}


