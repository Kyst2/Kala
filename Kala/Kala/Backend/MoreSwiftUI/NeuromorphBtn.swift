import Foundation
import SwiftUI

struct NeuromorphBtn: View {
    let text: LocalizedStringKey
    let action: () -> ()
    
    @Environment(\.colorScheme) var theme
    
    init (_ text: LocalizedStringKey, action: @escaping () -> ()) {
        self.text = text
        self.action = action
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
        .buttonStyle(NeumorphicButtonStyle(width: 200, cornerRadius : 20))
    }
}
