import SwiftUI
import Foundation
import Combine

struct KalaMainView: View {
    @ObservedObject var model = MainViewModel.shared
    
    var body: some View {
        StopwatchInterfaceView(model: model)
            .wndAccessor { window in
                let closeButton = window?.standardWindowButton(.closeButton)
                
                closeButton?.action = #selector(NSWindow.doMyClose(_:))
            }
            .frame(minWidth: 500, idealWidth: 600 , maxWidth: .infinity, minHeight: 200, idealHeight: 300, maxHeight: .infinity)
            .background(VisualEffectView(type: .behindWindow, material: .m2_menu))
//            .preferredColorScheme(.light)
    }
}

struct StopwatchInterfaceView: View {
    @ObservedObject var model: MainViewModel
    
    let copyPublisher = PassthroughSubject<Void, Never>()
    
    init(model: MainViewModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 20){
            Text(model.timePassedStr)
                .foregroundColor(.gray)
                .font(.system(size: 40,design: .monospaced))
                .addTextBlinker(subscribedTo: copyPublisher, duration: 1.5)
                .onTapGesture {
                    // implement copy text here
                    
                    copyPublisher.send()
                }
            
            HStack(spacing: 40) {
                if model.config.isGoing {
                    NeuromorphBtn("Pause") { model.pause()}
                        .keyboardShortcut(" ", modifiers: [])
                } else {
                    NeuromorphBtn("Start") { model.start()}
                        .keyboardShortcut(" ", modifiers: [])
                }
                
                if model.timePassedStr != "00:00:00.000" {
                    NeuromorphBtn("Reset") { model.reset() }
                        .keyboardShortcut("r", modifiers: [])
                }
            }.padding()
        }
    }
}


////////////////////////////
///HELPERS
///////////////////////////

extension NSWindow {
    @objc
    func doMyClose(_ sender: Any?) {
        
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
                askAlert1()
            }
        }
    }

    
    func askAlert1() {
        let appDel = AppDelegate.instance!
        appDel.showCustomAlert()
        
        
//        let alert = NSAlert()
//        alert.messageText = "Предупреждение"
//        alert.informativeText = "Вы уверены, что хотите закрыть приложение?"
//        alert.addButton(withTitle: "Закрыть с сохранением")
//        alert.addButton(withTitle: "Нет")
//        alert.addButton(withTitle: "Не сохранять ")
//        if MainViewModel.shared.config.isGoing == true {
//            alert.addButton(withTitle: "Сохранить и продолжить оффлайн?")
//        }
//
//        switch alert.runModal() {
//        case .alertFirstButtonReturn:
//            MainViewModel.shared.pause()
//            NSApplication.shared.terminate(self)
//        case .alertThirdButtonReturn:
//            MainViewModel.shared.pause()
//            MainViewModel.shared.config.timePassedInterval = CFTimeInterval(0)
//            NSApplication.shared.terminate(self)
//        default:
//            alert.window.close()
//            break;
//        }
    }
}
