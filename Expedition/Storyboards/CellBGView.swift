//
//  CellBGView.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 11/20/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class CellBGView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 20.0
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
    }

}
