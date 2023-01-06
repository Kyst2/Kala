import SwiftUI

struct KalaMainView: View {
    
    @ObservedObject var stopWatchManager = StopWatchManager()
    var stopWatch = Stopwatch()
    
    var body: some View {
        VStack{
            HStack{
//                Text("\():")
//                    .font(.custom("Avenir", size: 60))
                Text(String(format: "%.0f", stopWatchManager.secondsElapsed))
                    .font(.custom("Avenir", size: 60))
                    
            }.frame(width: 300, height: 300, alignment: .center)
            
            
            if stopWatchManager.mode == .stopped {
                Button {self.stopWatchManager.start()} label: {
                    TimerButton(label: "Start", buttonColor: .orange, textColor: .black)
                }
                .buttonStyle(.plain)
            }
            
            if stopWatchManager.mode == .runned {
                Button {self.stopWatchManager.pause()} label: {
                    TimerButton(label: "Pause", buttonColor: .orange, textColor: .black)
                }.buttonStyle(.plain)
            }
            
            if stopWatchManager.mode == .paused {
                Button {self.stopWatchManager.start()} label: {
                    TimerButton(label: "Start", buttonColor: .orange, textColor: .black)
                }.buttonStyle(.plain)
                Button {self.stopWatchManager.stop()} label: {
                    TimerButton(label: "Stop", buttonColor: .red, textColor: .white)
                }.buttonStyle(.plain)
                    .padding(.top, 10)
            }
            Spacer()
        }
        .backgroundGaussianBlur(type: .behindWindow, material: .m6_tooltip)
        .ignoresSafeArea(.all)
        .wndAccessor { window in
            
            let closeButton = window?.standardWindowButton(.closeButton)
            
            closeButton?.action = #selector(NSWindow.doMyClose(_:))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        KalaMainView()
    }
}

struct TimerButton: View {
    
    let label: String
    let buttonColor: Color
    let textColor: Color
    
    var body: some View {
        Text(label)
            .foregroundColor(textColor)
            .padding(.vertical,20)
            .padding(.horizontal,90)
            .background(buttonColor)
            .cornerRadius(15)
            
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
            NSApplication.shared.terminate(StopWatchManager().stop())
            
            default:
                alert.window.close()
                break;
        }
    }
}
