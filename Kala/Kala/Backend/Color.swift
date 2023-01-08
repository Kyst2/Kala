import Foundation
import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

extension View {
    func NeumorphicStyle() -> some View {
        self.padding(30)
        //      .frame(maxWidth: .infinity)
            .padding(.vertical,5)
            .padding(.horizontal,90)
            .background(Color.offWhite)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.5), radius: 10, x: -2, y: -2)
    }
}
