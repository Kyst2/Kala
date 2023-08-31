import Foundation
import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

@available(OSX 10.15, *)
public extension Color {
    init(rgbaHex: UInt32) {
        self.init(
            red:      Double((rgbaHex >> 24) & 0xFF) / 256.0,
            green:    Double((rgbaHex >> 16) & 0xFF) / 256.0,
            blue:     Double((rgbaHex >> 8) & 0xFF) / 256.0,
            opacity:  Double(rgbaHex & 0xFF) / 256.0
        )
    }
}
