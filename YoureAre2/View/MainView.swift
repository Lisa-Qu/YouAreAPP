//
//  MainView.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/16.
//

import SwiftUI
import ConfettiView
import UIKit  // For UIColor conversion

struct MainView: View {
    @StateObject var viewModel = BlockViewModel()
    
    // Sheet control
    @State private var showAddSheet = false
    @State private var selectedBlock: Block?
    
    // Toggle controls
    @State private var showEmoji = false
    @State private var showCarousel = false
    
    // Top-Three Selection Mode
    @State private var keysNum: Int = 0
    @State private var isSelectingTopThree = false
    @State private var selectedBlockIDs: [UUID] = []
    
    // Overlays & Confetti
    @State private var showGreyOverlay = false
    @State private var showCongratsText = false
    
    // ConfettiView wrapper
    @State private var confettiWrapper = ConfettiViewWrapper()
    @State private var showConfetti = false

    @State private var showGuide = false
    
    var body: some View {
        NavigationView {
            ZStack {
                mainContent
                overlays
            }
            .navigationTitle("")
            .toolbar {
                toolbarContent
            }
            .onAppear {
                if viewModel.blocks.isEmpty {
                    viewModel.blocks = Block.templateBlocks
                }
            }
            // Apply sheets and overlay modifiers to the same NavigationView scope
            .sheet(isPresented: $showAddSheet) {
                AddBlockView { newBlock in
                    viewModel.blocks.append(newBlock)
                }
            }
            .sheet(item: $selectedBlock) { block in
                BlockDetailView(block: block, viewModel: viewModel)
            }
            .overlay(bottomFixedButton, alignment: .bottom)
            .overlay(
                Group {
                    if showGuide {
                        GuideView(
                            guideText: getGuideText(),
                            isPresented: $showGuide
                        )
                    }
                }
            )
        }
    }
}

extension MainView {
    // Main content area: either the carousel screen or the main draggable canvas.
    private var mainContent: some View {
        Group {
            if showCarousel {
                AnimatedCarouselView()
            } else {
                VStack(spacing: 10) {
                    // Title text
                    if isSelectingTopThree {
                        Text("Which three blocks do you feel most empowered by today? ✊\n Click to select! 👈")
                            .font(.title.weight(.black))
                            .dynamicTypeSize(.xSmall)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    } else {
                        Text("Inner♥️ home🏠")
                            .font(.title.weight(.black))
                            .dynamicTypeSize(.xSmall)
                            .multilineTextAlignment(.center)
                    }
                    
                    // Main canvas content
                    ZStack {
                        (showEmoji ? Color.black : Color.white)
                            .ignoresSafeArea()
                        
                        ForEach($viewModel.blocks) { $block in
                            DraggableBlockView(
                                block: $block,
                                onTap: { handleBlockTap(block: $block) },
                                showEmoji: showEmoji,
                                isSelected: .init(
                                    get: { isSelectingTopThree && selectedBlockIDs.contains(block.id) },
                                    set: { _ in }
                                )
                            )
                        }
                    }
                }
            }
        }
    }
    
    // Overlays for grey background, confetti, and congratulatory text.
    private var overlays: some View {
        ZStack {
            if showGreyOverlay {
                Color(hex: "D9D9D9")
                    .opacity(0.9)
                    .ignoresSafeArea()
            }
            confettiWrapper
                .opacity(showConfetti ? 1 : 0)
                .ignoresSafeArea()
            if showCongratsText {
                CongratulationsTextView(text: "Congratulations 🥳!\n🗝️+1")
            }
        }
    }
    
    // Toolbar content: left side with tree and lightswitch buttons; right side with "Add" (only when not in carousel).
    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button { showCarousel.toggle() } label: {
                    Image(systemName: showCarousel ? "tree.circle.fill" : "tree.circle")
                }
                Button { showEmoji.toggle() } label: {
                    Image(systemName: showEmoji ? "lightswitch.on.fill" : "lightswitch.on")
                        .rotationEffect(.degrees(90))
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if !showCarousel {
                    Button("Add") { showAddSheet = true }
                }
            }

                    ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button {
                        showGuide = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                    
                    if !showCarousel {
                        Button("Add") { showAddSheet = true }
                    }
                }
            }
        }
    }
    
    // Bottom fixed button to toggle top-three selection mode.
    private var bottomFixedButton: some View {
        Group {
            if !showCarousel {
                VStack {
                    Spacer()
                    Button(action: {
                        if isSelectingTopThree {
                            isSelectingTopThree = false
                            selectedBlockIDs.removeAll()
                        } else {
                            isSelectingTopThree = true
                            selectedBlockIDs.removeAll()
                        }
                    }) {
                        if isSelectingTopThree {
                            Text("Cancel")
                                .foregroundColor(.blue)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                        } else {
                            Text("🗝️\(keysNum)")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    // Handle a tap on a block.
    private func handleBlockTap(block: Binding<Block>) {
        if isSelectingTopThree {
            if selectedBlockIDs.contains(block.wrappedValue.id) {
                selectedBlockIDs.removeAll { $0 == block.wrappedValue.id }
            } else {
                selectedBlockIDs.append(block.wrappedValue.id)
            }
            if selectedBlockIDs.count == 3 {
                TopThreeSelectionManager.triggerSelection(
                    keysNum: $keysNum,
                    showGreyOverlay: $showGreyOverlay,
                    showConfetti: $showConfetti,
                    showCongratsText: $showCongratsText,
                    isSelectingTopThree: $isSelectingTopThree,
                    selectedBlockIDs: $selectedBlockIDs,
                    confettiContents: .init(
                        get: { [] },
                        set: { contents in
                            confettiWrapper.emit(with: contents, for: 3.0)
                        }
                    ),
                    blocks: viewModel.blocks
                )
            }
        } else {
            selectedBlock = block.wrappedValue
        }
        
    }
    private func getGuideText() -> String {
        if showCarousel {
            return "🤲 Welcome to the Carousel View!\n\n 👉 Swipe left/right to browse different blocks\n 🔵 Tap on a block to view its details\n 🌳 Use the tree icon to return to main canvas"
        } else if showEmoji {
            return "🌑 Dark Mode activated!\n\n 🤩 Blocks will display their emojis\n 🫨 Blocks will gently shake\n 🔙 Toggle the switch icon to return to light mode"
        } else if isSelectingTopThree {
            return "🗝️ Top Three Selection Mode\n\n 🔵 Select three blocks that strengthened your identity today\n 🟡 Selected blocks will be highlighted\n 🗝️ Get a key when you complete the selection"
        } else {
            return "🏠 Main Canvas\n\n 👉 Drag blocks to arrange them\n 🫵 Tap a block to view/edit details\n 🗝️ Use the key counter to enter selection mode\n ➕ Add new blocks with the Add button"
        }
    }
    
    struct CongratulationsTextView: View {
        let text: String
        let colors: [Color] = [
            Color(hex: "0000FF"),
            Color(hex: "4B0082"),
            Color(hex: "8A2BE2"),
            Color(hex: "800080"),
            Color(hex: "FF00FF"),
            Color(hex: "FF69B4"),
            Color(hex: "FF4500"),
            Color(hex: "FF8C00"),
            Color(hex: "FFA500"),
            Color(hex: "FFFF00"),
            Color(hex: "ADFF2F"),
            Color(hex: "008000"),
            Color(hex: "008080"),
            Color(hex: "00FFFF"),
            Color(hex: "FF0000")
        ]
        
        var body: some View {
            VStack {
                ForEach(text.split(separator: "\n"), id: \.self) { line in
                    HStack(spacing: 0) {
                        ForEach(Array(line.enumerated()), id: \.offset) { index, char in
                            Text(String(char))
                                .font(.largeTitle.bold())
                                .foregroundColor(colors[index % colors.count])
                        }
                    }
                }
            }
            .multilineTextAlignment(.center)
        }
    }

    struct GuideView: View {
        let guideText: String
        @Binding var isPresented: Bool
        
        var body: some View {
            ZStack {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented = false
                    }
                
                VStack(spacing: 16) {
                    Text("Guide")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                    
                    Text(guideText)
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .frame(maxWidth: 300)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .padding()
            }
        }
    }
    
    #Preview {
        MainView()
            .onAppear {
                let previewViewModel = BlockViewModel()
                previewViewModel.blocks = [
                    Block(name: "快乐", emoji: "😊", shape: .circle, color: .yellow),
                    Block(name: "爱心", emoji: "❤️", shape: .square, color: .red),
                    Block(name: "星星", emoji: "⭐️", shape: .triangle, color: .blue)
                ]
                if let viewModelMirror = Mirror(reflecting: previewViewModel).children.first(where: { $0.label == "blocks" }) {
                    if let blocks = viewModelMirror.value as? [Block] {
                        previewViewModel.blocks = blocks
                    }
                }
            }
    }
}
