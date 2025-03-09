//
//  AddBlockView.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/17.
//

import SwiftUI

public struct AddBlockView: View {
    /// We use Environment's dismiss to close the sheet
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedShape: BlockShape = .circle
    @State private var selectedColor: Color = .blue
    @State private var name: String = ""
    @State private var emoji: String = "🙂"  // NEW: Store the chosen emoji
    @State private var showEmojiPicker: Bool = false  // Controls showing the emoji picker sheet
    
    /// Callback that passes back the newly created block
    var onCreate: (Block) -> Void

    public init(onCreate: @escaping (Block) -> Void) {
        self.onCreate = onCreate
    }
    public var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Name")) {
                    TextField("Enter block name", text: $name)
                }
                
                Section(header: Text("Shape")) {
                    Picker("Shape", selection: $selectedShape) {
                        Text("Circle").tag(BlockShape.circle)
                        Text("Square").tag(BlockShape.square)
                        Text("Triangle").tag(BlockShape.triangle)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Color")) {
                    ColorPicker("Pick a color", selection: $selectedColor)
                }
                

                Section(header: Text("Icon")) {
                    HStack {
                        Spacer()
                        Button(action: {
                            showEmojiPicker = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 60, height: 60)
                                Text(emoji)
                                    .font(.largeTitle)
                            }
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Add Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        // Build a new Block with the chosen emoji
                        let newBlock = Block(
                            name: name,
                            emoji: emoji,
                            shape: selectedShape,
                            color: selectedColor
                        )
                        // Call the callback
                        onCreate(newBlock)
                        // Dismiss the sheet
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showEmojiPicker) {
            EmojiPickerView(selectedEmoji: $emoji)
        }
    }
}

public struct EmojiPickerView: View {
    @Binding var selectedEmoji: String
    @Environment(\.dismiss) var dismiss
    
    let emojis = EmojiData.allEmojis
    let columns = [GridItem(.adaptive(minimum: 40))]
    
        // 添加 public 初始化器
    public init(selectedEmoji: Binding<String>) {
        self._selectedEmoji = selectedEmoji
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(.largeTitle)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                selectedEmoji = emoji
                                dismiss()
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Select an Emoji")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddBlockView { newBlock in
        // 预览中不需要实际处理新创建的块
        print("Created new block: \(newBlock.name)")
    }
}

