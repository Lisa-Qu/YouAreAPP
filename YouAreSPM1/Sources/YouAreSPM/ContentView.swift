
//
//  ContentView.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/16.
//

import SwiftUI

public struct ContentView: View {
    @State private var showSplash = true
    
    public init() {}
    
    public var body: some View {
//        Group {
//            if showSplash {
//                SplashView()
//            } else {
//                MainView()
//            }
//        }
        MainView()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
