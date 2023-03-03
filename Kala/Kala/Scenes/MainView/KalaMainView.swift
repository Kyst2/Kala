import SwiftUI
import Foundation
import Combine

struct KalaMainView: View {
    @ObservedObject var model = MainViewModel.shared
    
    var body: some View {
        ZStack {
            VisualEffectView(type: .behindWindow, material: .m6_tooltip)
            
            DragWndView()
            
            StopwatchInterfaceView(model: model)
                .padding(EdgeInsets(top: 25, leading: 40, bottom: 25, trailing: 40))
        }
        .ignoresSafeArea()
        .wndAccessor{
            if let wnd = $0 {
                wnd.standardWindowButton(.closeButton)?.action = #selector(NSWindow.doCustomClose(_:))
                
                SettingViewModel.floatWindowUpd()
            }
        }
    }
}

struct StopwatchInterfaceView: View {
    @ObservedObject var model: MainViewModel
    
    @Environment(\.colorScheme) var theme
    var themeIsDark: Bool { theme == .dark}
    
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

extension StopwatchInterfaceView {
    func timerPanel() -> some View {
        Text(model.timePassedStr)
            .foregroundColor(themeIsDark ? .gray : .darkGray)
            .font(.system(size: 40,design: .monospaced))
            .dragWndWithClick()
            .contextMenu {
                Button("Copy stopwatch value") {
                    copyToClipBoard(textToCopy: model.timePassedStr)
                }
            }
    }
    
    @ViewBuilder
    func salaryPanel() -> some View {
        if model.config.displaySalary {
            VStack{
                Text(model.salary)
                    .foregroundColor(themeIsDark ? .orange : .blue )
                    .font(.system(size: 14, design: .monospaced))
                    .padding(.top, 5)
                    .dragWndWithClick()
                    .contextMenu{
                        Button("Copy Salary") {
                            copyToClipBoard(textToCopy: model.salary)
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
            }
            
            if model.st.isGoing {
                NeuromorphBtn("Pause") { model.pause()}
                    .keyboardShortcut(" ", modifiers: [])
            } else {
                NeuromorphBtn("Start") { model.start()}
                    .keyboardShortcut(" ", modifiers: [])
            }
        }
    }
}

////////////////////////////
///HELPERS
///////////////////////////

fileprivate func copyToClipBoard(textToCopy: String) {
    let pasteBoard = NSPasteboard.general
    pasteBoard.clearContents()
    pasteBoard.setString(textToCopy, forType: .string)
}

fileprivate extension NSWindow {
    @objc
    func doCustomClose(_ sender: Any?) {
        if MainViewModel.shared.st.isGoing {
            switch Config.shared.saveIsGoingSettings {
            case .AskAction:
                AppDelegate.instance.showCustomAlert()
            default:
                MainViewModel.shared.updConfig()
                MainViewModel.shared.st.pause()
                NSApplication.shared.terminate(self)
            }
        } else {
            switch Config.shared.saveStopSettings {
            case .AskAction:
                AppDelegate.instance.showCustomAlert()
            case .SaveAndClose :
                MainViewModel.shared.updConfig()
                MainViewModel.shared.pause()
                NSApplication.shared.terminate(self)
            default:
                MainViewModel.shared.updConfig()
                MainViewModel.shared.st.pause()
                NSApplication.shared.terminate(self)
            }
        }
    }
}
