import SwiftUI
import Foundation

struct KalaMainView: View {
    @ObservedObject var model = MainViewModel()
    
    var body: some View {
        StopwatchInterfaceView(model: model)
            .frame(width: 350, height: 350)
            .background(Color.offWhite)
            .ignoresSafeArea()
            .wndAccessor { window in
                let closeButton = window?.standardWindowButton(.closeButton)
                
                closeButton?.action = #selector(NSWindow.doMyClose(_:))
            }
            
    }
}

struct StopwatchInterfaceView: View {
    @ObservedObject var model = MainViewModel()
    
    var body: some View {
        VStack{
            HStack{
                Text(model.timePassedStr)
                    .foregroundColor(.gray)
                    .font(.system(size: 24,design: .monospaced))
                    .NeumorphicStyle()
                    .padding()
                    .padding(.leading,15)
                Spacer()
            }
            
            HStack {
                if model.isGoing {
                    Button ("Pause") {
                        model.pause()
                    }.font(.system(size: 20,design: .monospaced))
                    .foregroundColor(.gray)
                        .buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 20)))
                        .padding(.trailing,50)
                    //
                } else {
                    Button("Start") {
                        model.start()
                    }.font(.system(size: 20,design: .monospaced))
                    .foregroundColor(.gray)
                        .buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 20)))
                        .padding(.trailing,50)
                    
                }
                if model.timePassedStr != "00:00:00.000" {
                    Button("Reset") {
                        model.reset()
                    }.font(.system(size: 20,design: .monospaced))
                    .foregroundColor(.gray)
                        .buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 20)))
                }
            }.padding()
                .padding(.top)
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
            KalaMainView()
        }
            
    }
}


