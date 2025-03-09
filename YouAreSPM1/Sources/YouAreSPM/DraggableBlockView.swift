//
//  DraggableBlockView.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/17.
//

import SwiftUI

public struct DraggableBlockView: View {
    /// Binding to the actual Block in the array, to keep the block updated.
    @Binding var block: Block
    
    /// Called when the user taps the shape.
    var onTap: () -> Void
    
    /// Whether to show the emoji overlay (dark background with emoji) and apply the shake effect.
    var showEmoji: Bool = false
    
    /// Whether the block is selected.
    @Binding var isSelected: Bool
    
    /// Tracks the in-progress drag offset.
    @State private var dragOffset: CGSize = .zero
    
    /// Trigger value for the subtle shake animation.
    @State private var shakeTrigger: CGFloat = 0

        public init(block: Binding<Block>, 
                onTap: @escaping () -> Void,
                showEmoji: Bool = false,
                isSelected: Binding<Bool>) {
        self._block = block
        self.onTap = onTap
        self.showEmoji = showEmoji
        self._isSelected = isSelected
    }
    
    public var body: some View {
        shapeView
            .modifier(ShakeEffect(animatableData: shakeTrigger))
            .position(x: block.x + dragOffset.width,
                      y: block.y + dragOffset.height)
            .gesture(dragGesture)
            .onTapGesture {
                onTap()
            }
            .onChange(of: showEmoji) { oldValue, newValue in
                if newValue {
                    withAnimation(Animation.linear(duration: 0.5).repeatForever(autoreverses: true)) {
                        shakeTrigger = 1
                    }
                } else {
                    withAnimation(.easeOut(duration: 0.5)) {  // 添加动画过渡
                        shakeTrigger = 0
                    }
                }
            }
    }
    
    /// The drag gesture updates `dragOffset` in real-time and permanently updates the block’s position on release.
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation
            }
            .onEnded { value in
                block.x += value.translation.width
                block.y += value.translation.height
                dragOffset = .zero
            }
    }
    
    /// Draws the shape based on block.shape.
    @ViewBuilder
    private var shapeView: some View {
        switch block.shape {
        case .circle:
            Circle()
                .fill(block.color)
                .frame(width: 70, height: 70)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 2, y: 2)
                .onChange(of: isSelected) { oldValue, newValue in
                    print("isSelected changed from \(oldValue) to \(newValue)")
                }
                .overlay(
                    Circle()
                        .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: isSelected ? 2 : 0)
                )
                .overlay(
                    Group {
                        if showEmoji {
                            ZStack {
//                                Color.black.opacity(0.5)
                                Text(block.emoji)
                                    .font(.largeTitle)
                            }
                        }
                    }
                )
        case .square:
            Rectangle()
                .fill(block.color)
                .frame(width: 70, height: 70)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 2, y: 2)
                .overlay(
                    Rectangle()
                        .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: isSelected ? 2 : 0)
                )
                .overlay(
                    Group {
                        if showEmoji {
                            ZStack {
//                                Color.black.opacity(0.5)
                                Text(block.emoji)
                                    .font(.largeTitle)
                            }
                        }
                    }
                )
        case .triangle:
            Triangle()
                .fill(block.color)
                .frame(width: 70, height: 70)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 2, y: 2)
                .overlay(
                    Triangle()
                        .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: isSelected ? 2 : 0)
                )
                .overlay(
                    Group {
                        if showEmoji {
                            ZStack {
//                                Color.black.opacity(0.5)
                                Text(block.emoji)
                                    .font(.largeTitle)
                            }
                        }
                    }
                )
        }
    }
}

/// Simple custom triangle shape.
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))    // Top center.
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))   // Bottom right.
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))   // Bottom left.
        path.closeSubpath()
        return path
    }
}

/// Shake effect for a subtle horizontal oscillation.
struct ShakeEffect: GeometryEffect {
    var shakesPerUnit = 3
    var amplitude: CGFloat = 2
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = amplitude * sin(animatableData * .pi * CGFloat(shakesPerUnit))
        return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
    }
}

#Preview {
    Group {
        // Preview for a circle.
        DraggableBlockView(
            block: .constant(Block(
                name: "圆形",
                emoji: "😊",
                shape: .circle,
                color: .blue,
                x: 100,
                y: 100
            )),
            onTap: { print("圆形被点击") },
            showEmoji: true,
            isSelected: .constant(true)  // 修改这里
        )
        
        // Preview for a square.
        DraggableBlockView(
            block: .constant(Block(
                name: "方形",
                emoji: "🎮",
                shape: .square,
                color: .green,
                x: 200,
                y: 100
            )),
            onTap: { print("方形被点击") },
            showEmoji: true,
            isSelected: .constant(false)  // 添加这个参数
        )
        
        // Preview for a triangle.
        DraggableBlockView(
            block: .constant(Block(
                name: "三角形",
                emoji: "🎯",
                shape: .triangle,
                color: .red,
                x: 300,
                y: 100
            )),
            onTap: { print("三角形被点击") },
            showEmoji: true,
            isSelected: .constant(false)  // 添加这个参数
        )
    }
    .frame(width: 400, height: 300)
    .background(Color.gray.opacity(0.1))
}
