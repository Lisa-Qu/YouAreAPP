//
//  Color+Extensions.swift
//  YoureAre2
//
//  Created by Lisa. Qu on 2025/2/22.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    // 保留现有的 darker 方法
    func darker(by percentage: CGFloat = 0.2) -> Color {
        guard let components = UIColor(self).cgColor.components else { return self }
        let factor = 1.0 - percentage
        
        return Color(
            red: max(components[0] * factor, 0),
            green: max(components[1] * factor, 0),
            blue: max(components[2] * factor, 0),
            opacity: components[3]
        )
    }
}
