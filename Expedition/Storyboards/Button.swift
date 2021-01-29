//
//  Button.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 1/28/21.
//  Copyright © 2021 The Morning Company. All rights reserved.
//

import UIKit

class Button: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
    }

}
