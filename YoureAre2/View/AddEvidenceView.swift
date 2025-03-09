//
//  AddEvidenceView.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/17.
//

import SwiftUI
import PhotosUI

struct AddEvidenceView: View {
    @Binding var block: Block
    @Environment(\.dismiss) var dismiss
    
    // CHANGED: no more "description." We simply call it "text."
    @State private var text = ""
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    @State private var isImageLandscape: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                // You can rename or remove the label entirely
                Section {
                    TextEditor(text: $text)
                        .frame(height: 100)
                }
                
                Section(header: Text("Picture")) {
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                            Text("Pick Image")
                        }
                    }
                    
                    if let selectedImage = selectedImage {
                        GeometryReader { geometry in
                            if isImageLandscape {
                                VStack {
                                    selectedImage
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width)
                                }
                            } else {
                                selectedImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: geometry.size.height)
                            }
                        }
                        .frame(height: 300)
                    }
                }
            }
            .navigationTitle("Add Evidence")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let evidence = Evidence(
                            text: text,
                            image: selectedImage
                        )
                        block.evidences.append(evidence)
                        dismiss()
                    }
                }
            }
        }
        // Load the selected photo
        .onChange(of: selectedItem) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    isImageLandscape = uiImage.size.width > uiImage.size.height
                    selectedImage = Image(uiImage: uiImage)
                }
            }
        }
    }
}

struct AddEvidenceView_Previews: PreviewProvider {
    static var previews: some View {
        AddEvidenceView(block: .constant(Block(
            name: "Sample Block",
            shape: .circle,
            color: .blue,
            evidences: []
        )))
    }
}

// 在文件底部添加
#Preview {
    AddEvidenceView(block: .constant(Block.sampleBlock))
}
