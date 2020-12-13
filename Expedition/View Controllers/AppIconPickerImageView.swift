//
//  AppIconPickerImageView.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 12/12/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class AppIconPickerImageView: UIImageView {

    //This sets the corner radius for the app icons in the options page for it
    
    override func awakeFromNib() {
        layer.cornerRadius = 14.0
        layer.cornerCurve = .continuous
        
    }
    

}
