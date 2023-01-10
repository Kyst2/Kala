import Foundation
import SwiftUI

struct NeuromorphBtn: View {
    let text: LocalizedStringKey
    let action: () -> ()
    
    @Environment(\.colorScheme) var theme
    
    let shortcutKey: KeyboardShortcut
    let help: LocalizedStringKey
    
    init (_ text: LocalizedStringKey, shortcutKey: KeyboardShortcut, help: LocalizedStringKey, action: @escaping () -> ()) {
        self.text = text
        self.action = action
        self.shortcutKey = shortcutKey
        self.help = help
    }
    
    var body: some View {
        Button(action: { action() } ) {
            Text(text)
                .padding(.horizontal, 30)
                .font(.system(size: 20,design: .monospaced))
                .foregroundColor( theme == .dark ? .gray : .gray)
                .fixedSize()
        }
        .buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 20)))
        .keyboardShortcut(shortcutKey)
        .help(help)
    }
}
