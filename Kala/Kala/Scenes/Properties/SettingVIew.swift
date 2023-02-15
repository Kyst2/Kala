import SwiftUI
import Foundation

struct SettingView: View {
    static let shared = SettingView()
    
    @ObservedObject var config = Config.shared
    
    var body: some View {
        VStack() {
            Spacer()
            Text("Close on pause:")
                .foregroundColor(.gray)
            
            StopTimerConfigDropDown()
                .padding(.horizontal,20)
            
            Text("Close during operation:")
                .foregroundColor(.gray)
            
            PlayTimerConfogDropDown()
                .padding(.horizontal,20)
            
            Toggle(isOn: config.$displayMs) { Text("Show milliseconds")
                    .foregroundColor(.gray)
            }
            
            Toggle(isOn: config.$topMost) { Text("On top of all the windows")
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .applyTextStyle()
        .frame(idealWidth: 300, maxWidth: 300, idealHeight: 300, maxHeight: 300)
        .background(VisualEffectView(type: .behindWindow, material: .m2_menu))
    }
}

/////////////////////////////
///Styles
////////////////////////////

fileprivate extension View {
    func applyTextStyle() -> some View {
        self
            .foregroundColor(.black)
            .pickerStyle(.menu)
    }
}
/////////////////////////////
///HELPERS
////////////////////////////

fileprivate extension SettingView {
    func StopTimerConfigDropDown() -> some View {
        Picker("", selection: config.$saveStopSettings) {
            ForEach(ActionTimerStopped.allCases, id: \.self) {
                Text($0.asStr())
                    .foregroundColor(.gray)
            }
        }
    }
    
    func PlayTimerConfogDropDown() -> some View {
        Picker("", selection: config.$saveIsGoingSettings) {
            ForEach(ActionTimerGoing.allCases, id: \.self) {
                Text($0.asStr())
                    .foregroundColor(.gray)
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
