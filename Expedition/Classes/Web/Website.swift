//
//  Website.swift
//  Expedition
//
//  Created by Julian Wright on 4/6/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import Foundation

class Website {
    var url:URL
    var title:String
    
    init(title:String, url:URL) {
        self.url = url
        self.title = title
    }
}
