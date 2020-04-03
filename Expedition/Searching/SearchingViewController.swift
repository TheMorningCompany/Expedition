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
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    @IBOutlet weak var accessibilityToolbar: UIToolbar!
    @IBOutlet weak var webViewTop: NSLayoutConstraint!
    @IBOutlet weak var toolbarBottom: NSLayoutConstraint!
    let notification = UINotificationFeedbackGenerator()//Haptics
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var lastOffsetY :CGFloat = 0
    let impact = UIImpactFeedbackGenerator() // Haptics
    var userAgentVar: String = "mobile" //User agent
    let credits: String = "zeqe golomb:ui designer;finbarr oconnell:programmer;jackson yan:programmer;julian wright:programmer" //Credits
    var searchEngine: String = "https://duckduckgo.com/" //Search engine initialization
    var components = URLComponents(string: "https://duckduckgo.com/") //Search engine
    
    //constants
    let timeoutDelay = 5.0
    
    @IBOutlet weak var searchBar: UITextField!
    
    override func viewDidLoad() { //Called when the app loads
        super.viewDidLoad()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont(name: "AvenirNext-Medium", size: UIFont.labelFontSize)
        var components = URLComponents(string: searchEngine)
       
        //MARK: SCROLLING STUFF
        webView.scrollView.delegate = self
        
        accessibilityToolbar.barTintColor = UIColor(named: "Expedition White")
        accessibilityToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        let url = URL(string: "https://duckduckgo.com/")
        
        let request = URLRequest(url: url!)
        
        components?.scheme = "https"
        components?.host = "duckduckgo.com"
        
        webView?.load(request)
       
        if UIDevice.current.userInterfaceIdiom == .pad {
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/7.4 Expedition/605.1.15"
        } else {
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/5.2 Mobile/15E148 Expedition/604.1"
        }
        
        webView?.addSubview(ActInd)
        ActInd?.startAnimating()
        
        webView?.navigationDelegate = self
        ActInd?.hidesWhenStopped = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(toolbarVisible), name: NSNotification.Name(rawValue: "toolbar"), object: nil)
        
        if UserDefaults.standard.bool(forKey: "reopen_tabs") {
            let fetchRequest: NSFetchRequest<HistoryElement> = HistoryElement.fetchRequest()
            
            do {
                let historyArray = try PersistenceService.context.fetch(fetchRequest)
                if historyArray.count > 0 {
                    openUrl(urlString: historyArray[0].url!)
                    print("OPEN: ", historyArray[0].url!)
                } else {
                    openUrl(urlString: url!.absoluteString)
                    print("OPEN: ", url!.absoluteString)
                }
            } catch {
                print("ERROR OCCURRED")
            }
        } else {
            openUrl(urlString: url!.absoluteString)
        }
        
        if let showToolbar:Bool = UserDefaults.standard.bool(forKey: "show_toolbar") {
            if (showToolbar) {
                accessibilityToolbar.isHidden = false
            } else {
                accessibilityToolbar.isHidden = true
            }
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
    }
    
    @objc func toolbarVisible() {
        if let showToolbar:Bool = UserDefaults.standard.bool(forKey: "show_toolbar") {
            if (showToolbar) {
                accessibilityToolbar.isHidden = false
            } else {
                accessibilityToolbar.isHidden = true
            }
        }
    }
    
    @objc func appMovedToBackground() {
        if let fadeOnClose:Bool = UserDefaults.standard.bool(forKey: "fade_on_close") {
            if (fadeOnClose) {
                performSegue(withIdentifier: "showBlankScreen", sender: self)
            }
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
            print("scroll up")
            self.webViewTop.constant = 46
            self.toolbarBottom.constant = 0
            UIView.animate(withDuration: 0.15) {
                self.view.layoutIfNeeded()
            }
        }
        else {
            print("scroll down")
            self.webViewTop.constant = 0
            self.toolbarBottom.constant = 100
            UIView.animate(withDuration: 0.15) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        impact.impactOccurred() // Haptics
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/7.4 Mobile/15E148 Expedition/604.1"
        } else {
            self.webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/7.4 Expedition/605.1.15"
            
        }
        ActInd?.startAnimating()
         
     }
     
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        impact.impactOccurred()//haptics

        ActInd?.stopAnimating()
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
        }
     }
     
     func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         notification.notificationOccurred(.error)//Haptic
         ActInd?.stopAnimating()
         standoutMessage(message: "FAILED NAVIGATION")
     }
    
    func verifyUrl (urlString: String?) -> Bool { //tests for url
        let url: URL?
        if (urlString!.contains(" ")){
            return false
        } else if urlString!.hasPrefix("http://") {
            url = URL(string: urlString!)
        } else {
            url = URL(string: "http://" + urlString!)
        }
        if let url = url {
            if (urlString!.contains(".") && !(urlString!.hasPrefix(".")) && !(urlString!.hasSuffix("."))) {
                if (UIApplication.shared.canOpenURL(url)) {
                    return true
                }
            }
        }
            return false
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
    
    func generateRequest(url: URL) -> URLRequest {
        let request = URLRequest(url: url)
        
        return request
    }
    
    func urlToString(url: URL) -> String {
        return "\(url)"
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
       
        if userAgentVar == "mobile" {
            // switches to desktop useragent
            webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/7.4 Expedition/605.1.15"
            userAgentVar = "desktop"
            print("USER AGENT: " + userAgentVar)
            webView.reload()
        } else {
            impact.impactOccurred()//Haptic // switchtes to mobile useragent
            webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/7.4 Mobile/15E148 Expedition/604.1"
            userAgentVar = "mobile"
            print("USER AGENT: " + userAgentVar)
            webView.reload()
        }
        
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
        if self.traitCollection.userInterfaceStyle == .light {
            if let url = Bundle.main.url(forResource: "NotFound", withExtension: "html") {
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
        } else {
            if let url = Bundle.main.url(forResource: "NotFoundDark", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
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
    @IBAction func shareButton(_ sender: Any) {
        let alert = UIAlertController(title: "Clear Browsing Data", message: "What do you want to  do?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Nothing", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "URL", style: .default, handler: { action in
            self.displayShareSheet(shareContent: self.searchBar.text!)
            self.impact.impactOccurred() //Haptics
        }))
        
        alert.addAction(UIAlertAction(title: "Page Snapshot", style: .default, handler: { action in
            let config = WKSnapshotConfiguration()
            var pageHeight:CGFloat = self.webView.scrollView.contentSize.height
            var pageWidth:CGFloat = self.webView.scrollView.contentSize.width
            
//            self.webView.evaluateJavaScript("document.body.offsetHeight", completionHandler: { (height, error) in
//                pageHeight = height
//            })
//
//            self.webView.evaluateJavaScript("document.body.offsetWidth", completionHandler: { (width, error) in
//                pageWidth = width
//            })
            
            standoutMessage(message: "DIMENSIONS: \(pageWidth), \(pageHeight)")
            
            config.rect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

            self.webView.takeSnapshot(with: config) { image, error in
                if let image = image {
                    print(image.size)
                    self.displayShareSheet(shareContent: image)
                }
            }
        }))
        
        self.present(alert, animated: true)
    }
}


