//
//  Util.swift
//  Expedition
//
//  Created by Julian Wright on 4/3/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import Foundation

func standoutMessage(message: String) {
    var messageToPrint = message.uppercased()
    if (!(messageToPrint.hasSuffix("!"))) {
        messageToPrint += "!"
    }
    print("\n\n-----------------------------------------\n\n")
    print("\(messageToPrint)")
    print("\n\n-----------------------------------------\n\n")
}
