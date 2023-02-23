import SwiftUI
import Foundation
import Combine

struct KalaMainView: View {
    @ObservedObject var model = MainViewModel.shared
    
    var body: some View {
        ZStack {
            VisualEffectView(type: .behindWindow, material: .m2_menu)
            
            DragWndView()
            
            StopwatchInterfaceView(model: model)
                .wndAccessor { window in
                    let closeButton = window?.standardWindowButton(.closeButton)
                    
                    closeButton?.action = #selector(NSWindow.doCustomClose(_:))
                    
                }
                .padding(40)
        }
        .ignoresSafeArea()
    }
}

struct StopwatchInterfaceView: View {
    @ObservedObject var model: MainViewModel
    @Environment(\.colorScheme) var theme
    var themeIsDark: Bool { theme == .dark}
    
    let copyPublisher = PassthroughSubject<Void, Never>()
    
    init(model: MainViewModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 20){
            HStack {
                timerPanel()
                salaryPanel()
            }
            
            buttonsPanel()
        }
    }
}

extension StopwatchInterfaceView {
    func timerPanel() -> some View {
        Text(model.timePassedStr)
            .foregroundColor(themeIsDark ? .gray : .darkGray)
            .font(.system(size: 40,design: .monospaced))
            .addTextBlinker(subscribedTo: copyPublisher, duration: 1.5)
            .onTapGesture {
                model.copyToClipBoard(textToCopy: model.timePassedStr)
                copyPublisher.send()
            }
    }
    
    @ViewBuilder
    func salaryPanel() -> some View {
        if model.config.displaySalary {
            Text(model.salary)
                .foregroundColor(themeIsDark ? .orange : .blue )
                .font(.system(size: 14, design: .monospaced))
                .onTapGesture {
                    model.copyToClipBoard(textToCopy: model.salary)
                    copyPublisher.send()
                }
        }
    }
    
    func buttonsPanel() -> some View {
        HStack(spacing: 40) {
            
            if model.timePassedStr != "00:00:00.000" {
                NeuromorphBtn("Reset") { model.reset() }
                    .keyboardShortcut("r", modifiers: [])
            }
            
            if model.config.isGoing {
                NeuromorphBtn("Pause") { model.pause()}
                    .keyboardShortcut(" ", modifiers: [])
            } else {
                NeuromorphBtn("Start") { model.start()}
                    .keyboardShortcut(" ", modifiers: [])
            }
        }.padding()
    }
}


////////////////////////////
///HELPERS
///////////////////////////

extension NSWindow {
    @objc
    func doCustomClose(_ sender: Any?) {
        
        if MainViewModel.shared.config.isGoing {
            switch Config.shared.saveIsGoingSettings {
            case .AskAction:
                askAlert1()
                break;
            case .TimeGoingOnKalaClose:
                MainViewModel.shared.st.offline()
                
                NSApplication.shared.terminate(self)
                break;
            case .SaveAndClose:
                MainViewModel.shared.pause()
                NSApplication.shared.terminate(self)
                break;
            case .NewSessionFromScratch:
                MainViewModel.shared.pause()
                MainViewModel.shared.config.timePassedInterval = CFTimeInterval(0)
                NSApplication.shared.terminate(self)
            }
        } else {
            switch Config.shared.saveStopSettings {
            case .SaveAndClose :
                MainViewModel.shared.pause()
                NSApplication.shared.terminate(self)
                break;
            case .NewSessionFromScratch:
                MainViewModel.shared.pause()
                MainViewModel.shared.config.timePassedInterval = CFTimeInterval(0)
                NSApplication.shared.terminate(self)
            case .AskAction:
                AppDelegate.instance.showCustomAlert()
            }
        }
    }
}
