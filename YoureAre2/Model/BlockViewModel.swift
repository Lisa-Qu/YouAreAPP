//
//  BlockViewModel.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/16.
//

import SwiftUI

/// Holds an array of Block.
class BlockViewModel: ObservableObject {
    @Published var blocks: [Block] = []
    
    init() {
        if blocks.isEmpty {
            blocks = Block.templateBlocks
        }
    }
}
