import SwiftUI

struct StopwatchInterfaceView: View {
    @ObservedObject var model: MainViewModel
    
    @Environment(\.colorScheme) var theme
    
    init(model: MainViewModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                timerPanel()
                
                salaryPanel()
            }
            .fixedSize()
            
            buttonsPanel()
        }
    }
}

fileprivate extension StopwatchInterfaceView {
    func timerPanel() -> some View {
        Text(model.timePassedStr)
            .foregroundColor(theme.isDark ? .gray : .darkGray)
            .font(.system(size: 40,design: .monospaced))
            .dragWndWithClick()
            .contextMenu {
                Button("Copy measured time") {
                    Clipboard.copy(text: model.timePassedStr)
                }
            }
    }
    
    @ViewBuilder
    func salaryPanel() -> some View {
        if Config.shared.displaySalary.value {
            VStack{
                HStack{
                    Text("[\(model.salary)\(Config.shared.currency.value.asStr())]")
                }
                .foregroundColor(theme.isDark ? .orange : .blue )
                .font(.system(size: 14, design: .monospaced))
                .padding(.top, 5)
                .dragWndWithClick()
                .contextMenu{
                    Button("Copy Salary") {
                        Clipboard.copy(text: "\(model.salary) \(Config.shared.currency.value.asStr())")
                    }
                }
                    
                Spacer()
            }
        }
    }
    
    func buttonsPanel() -> some View {
        HStack(spacing: 30) {
            if model.st.diff != 0 {
                NeuromorphBtn("Reset") { model.reset() }
                    .keyboardShortcut("r", modifiers: [])
                    .help("Keyboard shortcut: R")
            }
            
            if model.st.isGoing {
                NeuromorphBtn("Pause") { model.pause()}
                    .keyboardShortcut(" ", modifiers: [])
                    .help("Keyboard shortcut: SPACE")
            } else {
                NeuromorphBtn("Start", width: model.st.diff == 0 ? 330 : 150) { model.start()}
                    .keyboardShortcut(" ", modifiers: [])
                    .help("Keyboard shortcut: SPACE")
            }
        }
    }
}

////////////////////////////
///HELPERS
///////////////////////////

struct Clipboard {
    static func copy(text textToCopy: String ) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(textToCopy, forType: .string)
    }
}
