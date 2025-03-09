//
//  BlockViewModel.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/16.
//

import SwiftUI

/// Holds an array of Block.
public class BlockViewModel: ObservableObject {
    @Published public var blocks: [Block] = []
    
    public init() {
        if blocks.isEmpty {
            blocks = Block.templateBlocks
        }
    }
}
