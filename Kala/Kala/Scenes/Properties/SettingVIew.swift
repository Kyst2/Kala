import SwiftUI
import Foundation

struct SettingVIew: View {
    @AppStorage("Save_StopSettings") var saveStopSettings: ActionTimerStopped = .AskAction
    @AppStorage("Save_PlaySettings") var savePlaySettings: ActionTimerGoing = .AskAction
    @AppStorage("Save_Ms") var writeMSinStopwatch:
    MsYesOrNo = .Yes
    
    var body: some View {
        VStack(spacing:20) {
            Text("Закрытие на паузе:")
            
            StopTimerConfigDropDown()
            
            Text("Закрытие во время работы:")
            
            PlayTimerConfogDropDown()
            
            Text("Показывать милисекунды:")
            
            Picker("", selection: $writeMSinStopwatch, content: {
                ForEach(MsYesOrNo.allCases,id: \.self){
                    Text($0.asStr())
                }
            }).pickerStyle(.segmented)
                .background(.gray)
                .frame(width:200)
                .cornerRadius(10)

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

fileprivate extension SettingVIew {
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
        SettingVIew()
    }
}
