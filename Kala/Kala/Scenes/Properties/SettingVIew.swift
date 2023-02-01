import SwiftUI
import Foundation

struct SettingView: View {
    static let shared = SettingView()
    
    @AppStorage("Save_StopSettings") var saveStopSettings: ActionTimerStopped = .AskAction
    @AppStorage("Save_PlaySettings") var savePlaySettings: ActionTimerGoing = .AskAction
    
    @AppStorage("Save_Ms") var displayMs: Bool = false
    @AppStorage("Save_FloatingWindow") var topMost: Bool = false
    
    var body: some View {
        VStack() {
            Spacer()
            Text("Закрытие на паузе:")
            
            StopTimerConfigDropDown()
            
            Text("Закрытие во время работы:")
            
            PlayTimerConfogDropDown()
            
            Toggle(isOn: $displayMs) { Text("Показывать милисекунды") }
            
            Toggle(isOn: $topMost) { Text("Поверх всех окон") }
            
            Spacer()
        }
        .applyTextStyle()
        .frame(idealWidth: 300, maxWidth: 300, idealHeight: 300, maxHeight: 300)
        .background(Color.offWhite)
    }
}

/////////////////////////////
///Styles
////////////////////////////

fileprivate extension View {
    func applyTextStyle() -> some View {
        self
            .font(.system(size: 15, design: .monospaced))
            .foregroundColor(.black)
            .pickerStyle(.menu)
            .NeumorphicStyle()
    }
}
/////////////////////////////
///HELPERS
////////////////////////////

fileprivate extension SettingView {
    func StopTimerConfigDropDown() -> some View {
        Picker("", selection: $saveStopSettings) {
            ForEach(ActionTimerStopped.allCases, id: \.self) {
                Text($0.asStr())
                    .foregroundColor(.black)
            }
        }
    }
    
    func PlayTimerConfogDropDown() -> some View {
        Picker("", selection: $savePlaySettings) {
            ForEach(ActionTimerGoing.allCases, id: \.self) {
                Text($0.asStr())
                    .foregroundColor(.black)
            }
        }
    }
}

/////////////////////////////
///Previews
////////////////////////////

struct SettingVIew_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

