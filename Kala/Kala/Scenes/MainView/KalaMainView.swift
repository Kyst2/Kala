import SwiftUI

struct KalaMainView: View {
    
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    var body: some View {
        VStack{
            Text(String(format: "%.1f", stopWatchManager.secondsElapsed))
                .font(.custom("Avenir", size: 40))
                .padding(.top,150)
                .padding(.bottom,100)
                .padding(.trailing,200)
                .padding(.leading,200)
            
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
                    .NeumorphicStyle()
            }
            
            if stopWatchManager.mode == .paused {
                Button {self.stopWatchManager.start()} label: {
                    TimerButton(label: "Start", buttonColor: .orange, textColor: .black)
                }.buttonStyle(.plain)
                    .NeumorphicStyle()
                Button {self.stopWatchManager.stop()} label: {
                    TimerButton(label: "Stop", buttonColor: .red, textColor: .white)
                }.buttonStyle(.plain)
                    .NeumorphicStyle()
                    .padding(.top, 10)
            }
            
            Spacer()
        }
        .backgroundGaussianBlur(type: .behindWindow, material: .m1_hudWindow)
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
        alert.addButton(withTitle: "Yes")
        alert.addButton(withTitle: "Cancel")
        
        switch alert.runModal() {
        case .alertFirstButtonReturn:
            NSApplication.shared.terminate(self)
            break;
            
        default:
            alert.window.close()
            break;
        }
        
    }
}
