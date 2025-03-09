//
//  Block.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/16.
//

import SwiftUI

/// Possible shapes for a block.
enum BlockShape: CaseIterable {
    case circle
    case square
    case triangle
}

/// Represents one piece of user evidence, which can include text and/or an image.
struct Evidence: Identifiable {
    let id = UUID()
    // CHANGED: Removed "description" label. Now just "text" for user-entered text.
    var text: String
    var image: Image? = nil
}

/// A single block. Each has:
/// - A unique ID
/// - A user-chosen name and icon (emoji)
/// - A shape and color
/// - A draggable position on the main view
/// - An array of Evidence (text + image)
struct Block: Identifiable {
    let id = UUID()
    
    var name: String
    var emoji: String = "🙂" // NEW: Emoji icon for the block
    
    var shape: BlockShape = .circle
    var color: Color = .blue
    
    /// Position on the main view
    var x: CGFloat = 100
    var y: CGFloat = 100
    
    /// Evidence array (photos, text, etc.)
    var evidences: [Evidence] = []
}

extension Block {
    static let templateBlocks: [Block] = [
        Block(
            name: "Authentic",
            emoji: "🌈",
            shape: .circle,
            color: .purple,
            x:200,
            y: 190,
            evidences: [
                Evidence(
                    text: """
        Reflect on your gender identity and celebrate who you truly are. Everyone has the right to live authentically.

        (Long press for 2s to add more thoughts. Click right side to move right, left side to move left.)
        """
                )
            ]
        ),

        Block(
            name: "Confident",
            emoji: "💪",
            shape: .circle,
            color: .orange,
            x: 200,
            y: 300,
            evidences: [
                Evidence(
                    text: """
        Build and honor your self-confidence. Believe in your strengths to overcome challenges.

        (Long press for 2s to add more thoughts. Click right side to move right, left side to move left.)
        """
                )
            ]
        ),

        Block(
            name: "Unique",
            emoji: "🌟",
            shape: .square,
            color: .green,
            x:120,
            y: 220,            evidences: [
                Evidence(
                    text: """
        Embrace what makes you different. Your individuality adds color to the world.

        (Long press for 2s to add more thoughts. Click right side to move right, left side to move left.)
        """
                )
            ]
        ),

        Block(
            name: "Healthy",
            emoji: "🍏",
            shape: .square,
            color: .blue,
            x: 280,
            y: 220,
        
            evidences: [
                Evidence(
                    text: """
        Prioritize your well-being. A balanced mind and body foster overall happiness.

        (Long press for 2s to add more thoughts. Click right side to move right, left side to move left.)
        """
                )
            ]
        ),

        Block(
            name: "Loving",
            emoji: "❤️",
            shape: .triangle,
            color: .red,
            x: 120,
            y: 130,
            evidences: [
                Evidence(
                    text: """
        Practice compassion toward yourself. Recognize your worth and nurture your inner growth.

        (Long press for 2s to add more thoughts. Click right side to move right, left side to move left.)
        """
                )
            ]
        ),

        Block(
            name: "Positive",
            emoji: "☀️",
            shape: .triangle,
            color: .yellow,
            x: 280,
            y: 130,
            evidences: [
                Evidence(
                    text: """
        Focus on optimism. A positive outlook can brighten your path and inspire others.

        (Long press for 2s to add more thoughts. Click right side to move right, left side to move left.)
        """
                )
            ]
        ),
    ]
}
