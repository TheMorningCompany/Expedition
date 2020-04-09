//
//  URLUtil.swift
//  Expedition
//
//  Created by Julian Wright on 4/6/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import Foundation
import UIKit

func isSecure(url: String) {
    // https vs http checking here
}

func urlToString(url: URL) -> String {
    return "\(url)"
}

func switchUserAgent(agent: String) -> [String] {
    if agent == "mobile" {
        // switches to desktop useragent
        print("USER AGENT: " + agent)
        return ["desktop", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/7.4 Expedition/605.1.15"]
    } else {
        print("USER AGENT: " + agent)
        return ["mobile", "Mozilla/5.0 (iPhone; CPU iPhone OS 13_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/7.4 Mobile/15E148 Expedition/604.1"]
    }
}

func generateRequest(url: URL) -> URLRequest {
    let request = URLRequest(url: url)
    
    return request
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
                var response:URLResponse?
                do {
                    var data = try NSURLConnection.sendSynchronousRequest(generateRequest(url: URL(string: urlString!)!), returning: &response) as? NSData
                } catch {
                    print("Something Happened...")
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        return false
                    }
                    print(httpResponse.allHeaderFields)
                }
                return true
            }
        }
    }
        return false
}
