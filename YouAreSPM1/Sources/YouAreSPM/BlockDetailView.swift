//
//  BlockDetailView.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/17.
//

import SwiftUI

/// Max iPhone 14 Pro: width = 430, height = 932 points (for layout reference)
public struct BlockDetailView: View {
    /// Whenever `block` changes, this View updates.
    @State var block: Block
    
    /// The main ViewModel that holds all blocks.
    @ObservedObject var viewModel: BlockViewModel
    
    /// Controls whether the AddEvidenceView sheet is shown (triggered by long press in gallery).
    @State private var showingAddEvidence = false
    
    public var body: some View {
        ZStack {
            // 1) BACKGROUND = white
            normalizedColor(block.color).opacity(0.1)
                .ignoresSafeArea()
            
            
            // 2) SCROLL VIEW to avoid overlap on smaller screens
            ScrollView {
                // Use a VStack with a fixed spacing of 15 points
                VStack(alignment: .center) {
                    
                    Text("I am,")
                        .font(.title3.weight(.bold)) // Dynamic Type XSmall Title with bold weight
                        .foregroundColor(normalizedColor(block.color).opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 20)
                        .padding(.top, 45)
                    
                    ZStack(alignment: .center) {
                        TextEditor(text: $block.name)
                            .font(.title3.weight(.heavy)) // XSmall Title with extra bold weight
                            .frame(height: 50)
                            .foregroundColor(normalizedColor(block.color))
                            .multilineTextAlignment(.center)
                            .scrollContentBackground(.hidden)
                        
                        // 如果文本为空，显示占位符
                        if block.name.isEmpty {
                            Text("Sample Code")
                                .font(.title3.weight(.heavy)) // 占位符也使用相同的字体样式
                                .foregroundColor(normalizedColor(block.color))
                                .allowsHitTesting(false)
                        }
                    }
                    .frame(height: 60)
                    .background(normalizedColor(block.color).opacity(0.05))
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
                    
                    // GALLERY
                    GlideGallery(
                        slides: block.evidences.map { ev in
                            GlideSlide(
                                text: ev.text,
                                image: ev.image
                            )
                        },
                        textColor: normalizedColor(block.color).darker(by: 0.65),
                        backgroundColor: normalizedColor(block.color).opacity(0.1), // 添加背景色参数
                        onLongPress: {
                            showingAddEvidence.toggle()
                        }
                    )
                    .padding(.horizontal, 15)
                    .padding(.bottom, 15)
                    .frame(minHeight: 700)
                       }
            }
        }
        
        // 3) Update the block in our ViewModel when leaving
        .onDisappear {
            if let index = viewModel.blocks.firstIndex(where: { $0.id == block.id }) {
                viewModel.blocks[index] = block
            }
        }
        
        // 4) Present the AddEvidenceView sheet if showingAddEvidence == true
        .sheet(isPresented: $showingAddEvidence) {
            AddEvidenceView(block: $block)
        }
    }
}

// 在 BlockDetailView struct 外部添加
func normalizedColor(_ color: Color) -> Color {
    let uiColor = UIColor(color)
    
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0
    
    if uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
        let fixedSaturation: CGFloat = 1.0
        let fixedBrightness: CGFloat = 0.6
        
        return Color(hue: hue,
                     saturation: fixedSaturation,
                     brightness: fixedBrightness,
                     opacity: Double(alpha))
    } else {
        return color
    }
}

// 在文件底部添加
extension Block {
    static let sampleBlock = Block(
        name: "Sample Block",
        color: .yellow,
        evidences: [
            Evidence(text: "Hello World", image: nil),
            Evidence(text: "Another evidence", image: nil)
        ]
    )
}

#Preview {
    BlockDetailView(
        block: Block.sampleBlock,
        viewModel: BlockViewModel()
    )
}
