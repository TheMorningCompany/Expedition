//
//  GradientTitle.swift
//  TMCSuite2Test
//
//  Created by Zeqiel Golomb on 10/30/20.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.stop2, .stop1]), startPoint: .trailing, endPoint: .leading)
        
    }
}

struct Gradient_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}

extension Color {
    static let stop2 = Color("email")
    static let stop1 = Color("twitter")
}
