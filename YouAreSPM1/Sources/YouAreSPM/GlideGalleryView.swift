//
//  GlideGallery.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/18.
//

import SwiftUI

/// Simple model representing one slide in the gallery.
struct GlideSlide: Identifiable {
    let id = UUID()
    let text: String
    let image: Image?
}

/// The gallery view. Each slide is displayed vertically:
/// - If there's an image, it appears at the top with corner radius.
/// - Below it is scrollable text.
/// - Tapping the left half goes to the previous slide, right half to the next.
/// - Long-press triggers an external callback (e.g. to add evidence).
/// - Fixed height: 720 points.
///
struct GlideGallery: View {
    let slides: [GlideSlide]
    var textColor: Color
    var backgroundColor: Color
    var onLongPress: () -> Void
    
    @State private var currentIndex = 0
    @State private var direction: Direction = .forward
    
    enum Direction {
        case forward, backward
    }
    
    var body: some View {
        ZStack {
            if slides.isEmpty {
                VStack {
                    Text("No slides yet.\nLong press for 2s to add your first Evidence.")
                        .font(.title)
                        .fontWeight(.black)
                        .dynamicTypeSize(.xSmall)
                        .multilineTextAlignment(.center)
                        .foregroundColor(textColor)
                        .padding()
                    
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
                .cornerRadius(30)
                
            } else {
                ZStack {
                    // Show the current slide
                    VStack(spacing: 0) {
                        // 1) Top image (if any)
                        if let img = slides[currentIndex].image {
                            img
                                .resizable()
                                .scaledToFill()
                                .frame(width: 350)
                                .frame(maxHeight: 370)
                                .clipped()
                                .cornerRadius(20)
                                .padding(.top, 10)
                                .padding(.horizontal)
                        }
                        
                        // 2) Scrollable text
                        ScrollView {
                            Text(slides[currentIndex].text)
                                .font(.title)
                                .fontWeight(.black)
                                .dynamicTypeSize(.xSmall)
                                .foregroundColor(textColor)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(10)
                                .lineSpacing(8)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .background(backgroundColor)
                    .cornerRadius(30)
                    .frame(height: 550)
                    .transition(
                        direction == .forward
                            ? .move(edge: .trailing)
                            : .move(edge: .leading)
                    )
                    
                    // Invisible overlay to detect left vs. right taps
                    HStack(spacing: 0) {
                        // Left half → go backward
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    direction = .backward
                                    currentIndex = (currentIndex - 1 + slides.count) % slides.count
                                }
                            }
                        
                        // Right half → go forward
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    direction = .forward
                                    currentIndex = (currentIndex + 1) % slides.count
                                }
                            }
                    }
                }
            }
        }
        .animation(.easeInOut, value: currentIndex)
        .onLongPressGesture(minimumDuration: 2) {
            onLongPress()
        }
    }
}

// 更新预览代码
#Preview {
    GlideGallery(
        slides: [
            GlideSlide(text: "First slide text", image: Image(systemName: "photo")),
            GlideSlide(text: "Second slide text", image: Image(systemName: "photo.fill"))
        ],
        textColor: .blue,
        backgroundColor: .blue.opacity(0.2),
        onLongPress: {}
    )
    .padding()
}