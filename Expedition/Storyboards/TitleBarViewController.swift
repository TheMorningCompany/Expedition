//
//  TitleBarViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 10/30/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit
import SwiftUI

class TitleBarViewController: UIHostingController<GradientTitleBar> {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: GradientTitleBar())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
