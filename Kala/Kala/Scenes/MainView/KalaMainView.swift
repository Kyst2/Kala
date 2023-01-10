import SwiftUI
import Foundation

struct KalaMainView: View {
    @ObservedObject var model = MainViewModel()
    
    var body: some View {
        StopwatchInterfaceView(model: model)
            //.ignoresSafeArea()
            
            .frame(minWidth: 400, minHeight: 350)
            .preferredColorScheme(.light)
            .wndAccessor { window in
                let closeButton = window?.standardWindowButton(.closeButton)
                
                closeButton?.action = #selector(NSWindow.doMyClose(_:))
            }
    }
}

struct StopwatchInterfaceView: View {
    @ObservedObject var model = MainViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            Text(model.timePassedStr)
                .foregroundColor(.gray)
                .font(.system(size: 40,design: .monospaced))
            
            HStack(spacing: 40) {
                if model.isGoing {
                    NeuromorphBtn("Pause",
                                  shortcutKey: KeyboardShortcut(" "),
                                  help: "Press SPACE key to pause")
                    {
                        model.pause()
                    }
                } else {
                    NeuromorphBtn("Start",
                                  shortcutKey: KeyboardShortcut(" "),
                                  help: "Press SPACE key to Start")
                    {
                        model.pause()
                    }
                }
                if model.timePassedStr != "00:00:00.000" {
                    NeuromorphBtn("Reset",
                                  shortcutKey: KeyboardShortcut("R"),
                                  help: "Press R key to reset")
                    {
                        model.pause()
                    }
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
        let alert = NSAlert()
        
        alert.messageText = "Предупреждение"
        alert.informativeText = "Вы уверены, что хотите закрыть приложение?"
        alert.addButton(withTitle: "Закрыть с сохранением")
        alert.addButton(withTitle: "Нет")
        alert.addButton(withTitle: "Не сохранять ")
        alert.addButton(withTitle: "Сохранить и продолжить оффлайн?")
        switch alert.runModal() {
            case .alertFirstButtonReturn:
            NSApplication.shared.terminate(self)
//                break;
        case .alertThirdButtonReturn:
            NSApplication.shared.terminate(MainViewModel().reset())
            default:
                alert.window.close()
                break;
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            KalaMainView().preferredColorScheme(.dark)
            
            
            KalaMainView().preferredColorScheme(.light)
        }
    }
}
