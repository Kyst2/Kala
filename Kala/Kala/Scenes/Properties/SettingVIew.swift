//
//  SettingVIew.swift
//  Kala
//
//  Created by Andrew Kuzmich on 19.01.2023.
//

import SwiftUI

struct SettingVIew: View {
    @AppStorage("Save_StopSettings") var saveStopSettings: ActionTimerStopped = .AskAction
    @AppStorage("Save_PlaySettings") var savePlaySettings: ActionTimerGoing = .AskAction
    
    var body: some View {
        VStack(spacing:0){
            Picker("Закрытие на паузе", selection: $saveStopSettings) {
                pickerStopTimerSettings()
            }
            .font(.system(size: 15,design: .monospaced))
                .foregroundColor(.black)
                .pickerStyle(.menu)
                .NeumorphicStyle()
            Picker("Закрытие во время работы", selection: $savePlaySettings) {
                pickerplayTimerSettings()
            }
            .font(.system(size: 15,design: .monospaced))
                .foregroundColor(.black)
                .pickerStyle(.menu)
                .NeumorphicStyle()
                
            Spacer()
        }
//        .frame(width: 500, height: 300)
        .frame(maxWidth: 500, minHeight: 150, idealHeight: 300)
    }
}



extension SettingVIew {
    @ViewBuilder
    func pickerStopTimerSettings() -> some View {
        ForEach(ActionTimerStopped.allCases, id: \.self) {
            Text($0.asStr())
                .foregroundColor(.black)
        }
    }
    func pickerplayTimerSettings() -> some View {
        ForEach(ActionTimerGoing.allCases, id: \.self) {
            Text($0.asStr())
                .foregroundColor(.black)
        }
    }
}

struct SettingVIew_Previews: PreviewProvider {
    static var previews: some View {
        SettingVIew()
    }
}
