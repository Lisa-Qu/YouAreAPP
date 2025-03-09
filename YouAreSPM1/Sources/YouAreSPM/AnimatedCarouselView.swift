//
//  AnimatedCarouselView.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/XX.
//

import SwiftUI

struct AnimatedCarouselView: View {
    // Retrieve the carousel blocks data from our separate data file.
    let carouselBlocks = CarouselBlockData.blocks
    @State private var currentIndex: Int = 0

    var body: some View {
        ZStack {
            // Background changes to the current block's color with low opacity.
            carouselBlocks[currentIndex].color.opacity(0.05)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // MARK: Small Slide Carousel View (shows only the slide image)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(Array(carouselBlocks.enumerated()), id: \.element.id) { index, block in
                            block.slideImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 80)
                                .clipped()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(index == currentIndex ? Color.yellow : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    withAnimation {
                                        currentIndex = index
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // MARK: Detailed View for the Selected Carousel Block
                VStack(spacing: 16) {
                    Text(carouselBlocks[currentIndex].title)
                        .font(.largeTitle.weight(.black))
                        .dynamicTypeSize(.xSmall)
                        .foregroundColor(carouselBlocks[currentIndex].color)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        Text(carouselBlocks[currentIndex].subtitle)
                            .font(.title2.weight(.bold))
                            .dynamicTypeSize(.xSmall)
                            // Using the darker(by:) function and setting opacity to 0.7
                            .foregroundColor(carouselBlocks[currentIndex].color.darker(by: 0.2).opacity(0.7))
                        
                        carouselBlocks[currentIndex].detailImage
                            .resizable()
                            .scaledToFit()
                            .frame(width:350, height: 279)
                            .cornerRadius(40)
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Essence")
        }
    }
}

struct AnimatedCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedCarouselView()
    }
}
