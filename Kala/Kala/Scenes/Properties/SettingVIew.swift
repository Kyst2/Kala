import SwiftUI
import Foundation
import Combine
import AppCoreLight

struct SettingView: View {
    static let shared = SettingView()
    
//    @ObservedObject var appDisableTimeStamp : ConfigProperty<CFTimeInterval>
    @ObservedObject var saveStopSettings    : ConfigPropertyEnum<ActionTimerStopped>
    @ObservedObject var saveIsGoingSettings : ConfigPropertyEnum<ActionTimerGoing>
    @ObservedObject var currency            : ConfigPropertyEnum<CurrencyEnum>
    @ObservedObject var displayMs           : ConfigProperty<Bool>
    @ObservedObject var topMost             : ConfigProperty<Bool>
    @ObservedObject var timePassedInterval  : ConfigProperty<CFTimeInterval>
    @ObservedObject var displaySalary       : ConfigProperty<Bool>
    @ObservedObject var hourSalary          : ConfigProperty<Double>
    
    
    @Environment(\.colorScheme) var theme
    var themeIsDark: Bool { theme == .dark}
    
    init() {
//        appDisableTimeStamp = Config.shared.appDisableTimeStamp
        saveStopSettings = Config.shared.saveStopSettings
        saveIsGoingSettings = Config.shared.saveIsGoingSettings
        currency = Config.shared.currency
        displayMs = Config.shared.displayMs
        topMost = Config.shared.topMost
        timePassedInterval = Config.shared.timePassedInterval
        displaySalary = Config.shared.displaySalary
        hourSalary = Config.shared.hourSalary
    }
    var body: some View {
        ZStack{
            VisualEffectView(type:.behindWindow, material: themeIsDark ?  .m6_tooltip : .m1_hudWindow)
            
            DragWndView()
            VStack() {
                Spacer()
                
                Text("Close on pause:")
                    .foregroundColor(themeIsDark ? .gray : .darkGray)
                
                StopTimerConfigDropDown()
                    .padding(.horizontal,20)
                
                Text("Close during operation:")
                    .foregroundColor(themeIsDark ? .gray : .darkGray)
                
                PlayTimerConfogDropDown()
                    .padding(.horizontal,20)
                
                Toggle(isOn: displayMs.asBinding) { Text("Show milliseconds").foregroundColor(themeIsDark ? .gray : .darkGray) }
                
                HStack {
                    Toggle(isOn: displaySalary.asBinding) { Text(displaySalary.value ? "Hour salary" : "Display salary/hour").foregroundColor(themeIsDark ? .gray : .darkGray) }
                    
                    if displaySalary.value {
                        TextField("hour Salary", value: hourSalary.asBinding, format: .number)
                            .foregroundColor(themeIsDark ? .gray : .darkGray)
                            .frame(width: 50)
                            
                        CurrencyDropDown()
                            .fixedSize()
                    }
                }
                
                Toggle(isOn: topMost.asBinding) { Text("On top of all the windows").foregroundColor(themeIsDark ? .gray : .darkGray) }
                
                Spacer()
            }
            .applyTextStyle()
            .frame(minWidth: 200, idealWidth: 300 , maxWidth: 300, idealHeight: 300, maxHeight: 300)
            .wndAccessor {
                if let _ = $0 {
                    SettingViewModel.floatWindowUpd()
                }
            }
            
            .onChange(of: topMost.value) { _ in MainViewModel.shared.updTimerInterface(forceRefresh: true) }
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
        Picker("", selection: saveStopSettings.asBinding) {
            ForEach(ActionTimerStopped.allCases, id: \.self) {
                Text($0.asStr())
                    .foregroundColor(themeIsDark ? .gray : .darkGray)
            }
        }
    }
    
    func PlayTimerConfogDropDown() -> some View {
        Picker("", selection: saveIsGoingSettings.asBinding) {
            ForEach(ActionTimerGoing.allCases, id: \.self) {
                Text($0.asStr())
                    .foregroundColor(themeIsDark ? .gray : .darkGray)
            }
        }
    }
    
    func CurrencyDropDown() -> some View {
        Picker("", selection: currency.asBinding){
            ForEach(CurrencyEnum.allCases, id: \.self){
                Text($0.asStr())
                    .foregroundColor(themeIsDark ? .gray : .darkGray)
            }
        }
    }
    
}
