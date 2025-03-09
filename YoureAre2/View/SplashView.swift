//
//  SplashView.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/17.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(spacing: 16) {
                // "You Are" text
                Text("You Are")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: 261, height: 308) // If you really want fixed size
                
                // "believe In yourself, not their doubts"
                Text("believe In yourself,\nnot their doubts")
                    .font(.system(size: 24))
                    .foregroundColor(.yellow)
                    .multilineTextAlignment(.center)
                    .frame(width: 323, height: 96) // If you really want fixed size
            }
        }
    }
}
