//
//  TopThreeSelectionManager.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/22.
//

import SwiftUI
import ConfettiView  // Local package providing ConfettiView.Content
import UIKit

struct TopThreeSelectionManager {
    /// Triggers the top‑three selection process.
    /// - Parameters:
    ///   - keysNum: Binding for the key counter.
    ///   - showGreyOverlay: Binding controlling the grey overlay.
    ///   - showConfetti: Binding for showing the confetti view in MainView.
    ///   - showCongratsText: Binding for displaying the congratulatory text.
    ///   - isSelectingTopThree: Binding for the selection mode flag.
    ///   - selectedBlockIDs: Binding for the array of selected block IDs.
    ///   - confettiContents: Binding for the array of `ConfettiView.Content`.
    ///   - blocks: The current list of blocks (to determine block colors).
    static func triggerSelection(
        keysNum: Binding<Int>,
        showGreyOverlay: Binding<Bool>,
        showConfetti: Binding<Bool>,
        showCongratsText: Binding<Bool>,
        isSelectingTopThree: Binding<Bool>,
        selectedBlockIDs: Binding<[UUID]>,
        confettiContents: Binding<[ConfettiView.Content]>,
        blocks: [Block]
    ) {
        showGreyOverlay.wrappedValue = true
        
        var contents: [ConfettiView.Content] = []
        for id in selectedBlockIDs.wrappedValue {
            if let block = blocks.first(where: { $0.id == id }) {
                let uiColor = UIColor(block.color) // Convert SwiftUI Color to UIColor
                switch block.shape {
                case .circle:
                    contents.append(.shape(.circle, uiColor))
                case .square:
                    contents.append(.shape(.square, uiColor))
                case .triangle:
                    contents.append(.shape(.triangle, uiColor))
                }
            }
        }
        
        contents.append(.text("🎉"))
        
        confettiContents.wrappedValue = contents
        showConfetti.wrappedValue = true
        showCongratsText.wrappedValue = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            showGreyOverlay.wrappedValue = false
            showConfetti.wrappedValue = false
            showCongratsText.wrappedValue = false
            isSelectingTopThree.wrappedValue = false
            selectedBlockIDs.wrappedValue.removeAll()
            keysNum.wrappedValue += 1
        }
    }
}
