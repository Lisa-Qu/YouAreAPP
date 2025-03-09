//
//  ConfettiViewWrapper.swift
//  YoureAre2
//
//  Created by Lisa. Qu on [Date].
//

import SwiftUI
import ConfettiView  // Make sure the ConfettiView package is correctly imported
import UIKit

/// A SwiftUI wrapper for NSHipster's ConfettiView.
struct ConfettiViewWrapper: UIViewRepresentable {
    // Create the underlying ConfettiView instance.
    let confettiView = ConfettiView()
    
    func makeUIView(context: Context) -> ConfettiView {
        confettiView
    }
    
    func updateUIView(_ uiView: ConfettiView, context: Context) {
        // No update required.
    }
    
    /// Convenience method to emit confetti.
    /// - Parameters:
    ///   - contents: The confetti contents to emit.
    ///   - duration: The duration for the confetti emission.
    ///   - completion: An optional completion block called after the duration.
    func emit(with contents: [ConfettiView.Content],
              for duration: TimeInterval = 3.0,
              then completion: (() -> Void)? = nil) {
        // Call the underlying method without a trailing closure.
        confettiView.emit(with: contents, for: duration)
        
        // Manually call the completion block after the duration, if provided.
        if let completion = completion {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: completion)
        }
    }
}
