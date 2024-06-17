import Foundation
import SwiftUI

struct NeuromorphBtn: View {
    let text: LocalizedStringKey
    let width: CGFloat
    let action: () -> ()
    
    @Environment(\.colorScheme) var theme
    
    init (_ text: LocalizedStringKey, width: CGFloat = 150, action: @escaping () -> ()) {
        self.text = text
        self.action = action
        self.width = width
    }
    
    var body: some View {
        Button(action: { action() } ) {
            Text(text)
                .padding(.horizontal, 30)
                .font(.system(size: 20,design: .monospaced))
//                .foregroundColor(Color("gray"))
//                .foregroundColor( theme == .dark ? .gray : .gray)
                .fixedSize()
        }
        .buttonStyle(NeumorphicButtonStyle(width: width, height: 50, cornerRadius : 20))
    }
}
