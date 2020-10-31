//
//  GradientTitleBar.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 10/30/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import SwiftUI

struct GradientTitleBar: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.stop2, .stop1]), startPoint: .trailing, endPoint: .leading)
    }
}

struct Gradient_Previews: PreviewProvider {
    static var previews: some View {
        GradientTitleBar()
    }
}

extension Color {
    static let stop2 = Color("Stop2")
    static let stop1 = Color("Stop1")
}
