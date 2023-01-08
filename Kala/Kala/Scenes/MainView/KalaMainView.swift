import SwiftUI

struct KalaMainView: View {
    @ObservedObject var model = MainViewModel()
    
    var body: some View {
        StopwatchInterfaceView(model: model)
            .frame(width: 300, height: 300)
            .backgroundGaussianBlur(type: .behindWindow, material: .m6_tooltip)
            .ignoresSafeArea(.all)
            .wndAccessor { window in
                let closeButton = window?.standardWindowButton(.closeButton)
                
                closeButton?.action = #selector(NSWindow.doMyClose(_:))
            }
    }
}

struct StopwatchInterfaceView: View {
    @ObservedObject var model = MainViewModel()
    
    var body: some View {
        HStack{
            Text(model.timePassedStr)
            
            Spacer()
        }
        .frame(width: 100)
        
        HStack {
            if model.isGoing {
                Button ("Pause") {
                    model.pause()
                }
            } else {
                Button("Start") {
                    model.start()
                }
            }
            
            if model.timePassedStr != "00:00:00.000" {
                Button("Reset") {
                    model.reset()
                }
            }
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
        switch alert.runModal() {
            case .alertFirstButtonReturn:
            NSApplication.shared.terminate(self)
//                break;
        case .alertThirdButtonReturn:
//            NSApplication.shared.terminate(MainViewModel().stop())
            break;
            default:
                alert.window.close()
                break;
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        KalaMainView()
    }
}
