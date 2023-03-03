import SwiftUI
import Foundation

struct SettingView: View {
    static let shared = SettingView()
    
    @ObservedObject var config = Config.shared
    
    var body: some View {
        VStack() {
            Spacer()
            
            Text("Close on pause:")
            
            StopTimerConfigDropDown()
                .padding(.horizontal,20)
            
            Text("Close during operation:")
            
            PlayTimerConfogDropDown()
                .padding(.horizontal,20)
            
            Toggle(isOn: config.$displayMs) { Text("Show milliseconds") }
            
            HStack {
                Toggle(isOn: config.$displaySalary) { Text(config.displaySalary ? "Hour salary" : "Display salary/hour") }
                
                if config.$displaySalary.wrappedValue {
                    TextField("hour Salary", value: config.$hourSalary, format: .number)
                        .frame(width: 50)
                    Text("$")
                }
            }
            
            Toggle(isOn: config.$topMost) { Text("On top of all the windows") }
            
            Spacer()
        }
        .applyTextStyle()
        .frame(minWidth: 200, idealWidth: 300 , maxWidth: 300, idealHeight: 300, maxHeight: 300)
        .background(VisualEffectView(type: .behindWindow, material: .m6_tooltip))
        .wndAccessor {
            if let _ = $0 {
                SettingViewModel.floatWindowUpd()
            }
        }
    }
}

/////////////////////////////
///Styles
////////////////////////////

fileprivate extension View {
    func applyTextStyle() -> some View {
        self.foregroundColor(.gray)
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
