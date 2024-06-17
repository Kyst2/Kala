import SwiftUI
import Foundation
import Combine
import AppCoreLight

struct SettingView: View {
    static let shared = SettingView()
    
    @ObservedObject var saveStopSettings    : ConfigPropertyEnum<ActionTimerStopped>
    @ObservedObject var saveIsGoingSettings : ConfigPropertyEnum<ActionTimerGoing>
    @ObservedObject var currency            : ConfigPropertyEnum<Currency>
    @ObservedObject var displayMs           : ConfigProperty<Bool>
    @ObservedObject var topMost             : ConfigProperty<Bool>
    @ObservedObject var timePassedInterval  : ConfigProperty<CFTimeInterval>
    @ObservedObject var displaySalary       : ConfigProperty<Bool>
    @ObservedObject var hourSalary          : ConfigProperty<Double>
    
    @Environment(\.colorScheme) var theme
    
    init() {
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
            VisualEffectView(type:.behindWindow, material: theme.isDark ? .m6_tooltip : .m1_hudWindow)
            
            DragWndView()
            
            SettingViewInterface()
        }
    }
    
    func SettingViewInterface() -> some View {
        VStack() {
            Spacer()
            
            CloseOnPauseView()
            
            CloseDuringOperationView()
            
            ShowMillisecondsView()
            
            DisplaySalaryView()
            
            TopMostView()
            
            Spacer()
        }
        .applyTextStyle()
        .frame(minWidth: 200, idealWidth: 300 , maxWidth: 300, idealHeight: 300, maxHeight: 300)
        .onChange(of: topMost.value) { _ in MainViewModel.shared.updTimerInterface(forceRefresh: true) }
        .wndAccessor {
            if let _ = $0 {
                SettingViewModel.floatWindowUpd()
            }
        }
    }
    
    @ViewBuilder
    func CloseOnPauseView() -> some View {
        Text("Close on pause:")
            .foregroundColor(theme.isDark ? .gray : .darkGray)
        
        StopTimerConfigDropDown()
            .padding(.horizontal,20)
    }
    
    @ViewBuilder
    func CloseDuringOperationView() -> some View {
        Text("Close during operation:")
            .foregroundColor(theme.isDark ? .gray : .darkGray)
        
        PlayTimerConfogDropDown()
            .padding(.horizontal,20)
    }
    
    func ShowMillisecondsView() -> some View {
        Toggle(isOn: displayMs.asBinding) { Text("Show milliseconds").foregroundColor(theme.isDark ? .gray : .darkGray) }
    }
    
    func DisplaySalaryView() -> some View {
        HStack {
            Toggle(isOn: displaySalary.asBinding) { Text(displaySalary.value ? "Hour salary" : "Display salary/hour").foregroundColor(theme.isDark ? .gray : .darkGray) }
            
            if displaySalary.value {
                TextField("hour Salary", value: hourSalary.asBinding, format: .number)
                    .foregroundColor(theme.isDark ? .gray : .darkGray)
                    .frame(width: 50)
                
                CurrencyDropDown()
                    .fixedSize()
            }
        }
    }
    
    func TopMostView() -> some View {
        Toggle(isOn: topMost.asBinding) { Text("On top of all the windows").foregroundColor(theme.isDark ? .gray : .darkGray) }
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
                    .foregroundColor(theme.isDark ? .gray : .darkGray)
            }
        }
    }
    
    func PlayTimerConfogDropDown() -> some View {
        Picker("", selection: saveIsGoingSettings.asBinding) {
            ForEach(ActionTimerGoing.allCases, id: \.self) {
                Text($0.asStr())
                    .foregroundColor(theme.isDark ? .gray : .darkGray)
            }
        }
    }
    
    func CurrencyDropDown() -> some View {
        Picker("", selection: currency.asBinding){
            ForEach(Currency.allCases, id: \.self){
                Text($0.asStr())
                    .foregroundColor(theme.isDark ? .gray : .darkGray)
            }
        }
    }
}
