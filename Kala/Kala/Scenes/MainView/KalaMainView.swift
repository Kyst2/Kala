import SwiftUI
import Foundation

struct KalaMainView: View {    
    @ObservedObject var model: MainViewModel
    
    init(model: MainViewModel) {
        self.model = model
    }
    
    var body: some View {
        StopwatchInterfaceView(model: model)
            .wndAccessor { window in
                let closeButton = window?.standardWindowButton(.closeButton)
                
                closeButton?.action = #selector(NSWindow.doMyClose(_:))
            }
            .frame(minWidth: 400, minHeight: 350)
            .background(Color.offWhite)
        //.preferredColorScheme(.light)
    }
}

struct StopwatchInterfaceView: View {
    @ObservedObject var model: MainViewModel
    
    init(model: MainViewModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 20){
            Text(model.timePassedStr)
                .foregroundColor(.gray)
                .font(.system(size: 40,design: .monospaced))
            
            HStack(spacing: 40) {
                if model.isGoing {
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
        
        if KalaApp.mainVm.isGoing {
            switch Config.shared.saveIsGoingSettings {
            case .AskAction:
                askAlert1()
                break;
            case .TimeGoingOnKalaClose:
                KalaApp.mainVm.st.offline()
                NSApplication.shared.terminate(self)
                break;
            case .SaveAndClose:
                KalaApp.mainVm.pause()
                NSApplication.shared.terminate(self)
                break;
            case .NewSessionFromScratch:
                KalaApp.mainVm.pause()
                KalaApp.mainVm.timePassedInterval = CFTimeInterval(0)
                NSApplication.shared.terminate(self)
            }
        } else {
            switch Config.shared.saveStopSettings{
            case .SaveAndClose :
                KalaApp.mainVm.pause()
                NSApplication.shared.terminate(self)
                break;
            case .NewSessionFromScratch:
                KalaApp.mainVm.pause()
                KalaApp.mainVm.timePassedInterval = CFTimeInterval(0)
                NSApplication.shared.terminate(self)
            case .AskAction:
                askAlert1()
            break;
            }
            
        }
    }

    
    func askAlert1() {
        let alert = NSAlert()
        alert.messageText = "Предупреждение"
        alert.informativeText = "Вы уверены, что хотите закрыть приложение?"
        alert.addButton(withTitle: "Закрыть с сохранением")
        alert.addButton(withTitle: "Нет")
        alert.addButton(withTitle: "Не сохранять ")
        if KalaApp.mainVm.isGoing == true {
            alert.addButton(withTitle: "Сохранить и продолжить оффлайн?")
        }
        
        switch alert.runModal() {
        case .alertFirstButtonReturn:
            KalaApp.mainVm.pause()
            NSApplication.shared.terminate(self)
        case .alertThirdButtonReturn:
            KalaApp.mainVm.pause()
            KalaApp.mainVm.timePassedInterval = CFTimeInterval(0)
            NSApplication.shared.terminate(self)
        default:
            alert.window.close()
            break;
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            KalaMainView(model: MainViewModel())
            //                .preferredColorScheme(.dark)
            
            
//            KalaMainView(model: MainViewModel()).preferredColorScheme(.light)
        }
    }
}
