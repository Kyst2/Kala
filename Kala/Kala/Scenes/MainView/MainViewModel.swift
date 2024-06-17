import Foundation
import SwiftUI
import QuartzCore
import AppCoreLight
import AsyncNinja
import Combine

class MainViewModel: NinjaContext.Main , ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var timePassedStr: String
    @Published var salaryTime: Bool = Config.shared.displaySalary.value
    
    var salary: String = "0.00"
    
    private(set) var timer: Timer!
    let st = Stopwatch(startTime: nil)
    var counter = 0
    
    private override init() {
        self.timePassedStr = Config.shared.displayMs.value ? self.st.timeStrMs : self.st.timeStrS
        self.salaryTime = Config.shared.displaySalary.value ? false : true
        
        super.init()
        
        checkAppDisableTimeStamp()
        checkTimePassedInterval()
        updTimer()
        
        combineLatest(Config.shared.hourSalary.didSet, 
                      Config.shared.displaySalary.didSet,
                      Config.shared.currency.didSet
        )
        .onUpdate(context: self) { me, _ in
            me.updTimerInterface(forceRefresh: true)
        }
    }
    
    func checkAppDisableTimeStamp() {
        let appDisableTimeStamp:CFTimeInterval? = Config.shared.appDisableTimeStamp.value == 0 ? nil : Config.shared.appDisableTimeStamp.value
        
        if let appDisableTimeStamp = appDisableTimeStamp,
           Config.shared.saveIsGoingSettings.value == .TimeGoingOnKalaClose ||
           Config.shared.saveIsGoingSettings.value == .AskAction  {
            
            st.setDiffOffline(CACurrentMediaTime() - appDisableTimeStamp)
            start()
        }
    }
    
    func checkTimePassedInterval() {
        if Config.shared.timePassedInterval.value > 0 {
            st.setDiff(Config.shared.timePassedInterval.value)
        }
    }
    
    func updTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.09, repeats: true, block: { [self] _ in
            updTimerInterface()
            ///hack to save at least some user data in case of PC is rebooted unexpectedly or in case of Force Quit was initiated
            counter += 1
            if counter > 100 {
                Config.shared.timePassedInterval.value = st.diff
                counter = 0
            }
        })
    }
    
    func updTimerInterface(forceRefresh: Bool = false) {
        let newPassedStr = Config.shared.displayMs.value ? self.st.timeStrMs : self.st.timeStrS
        let salaryDouble = (self.st.diff/3600 * (Config.shared.hourSalary.value)).rounded(digits: 2)
        self.salary = "\( String(format: "%.2f", salaryDouble))"
        if self.timePassedStr != newPassedStr {
            // Must be first before timePassedStr change to be updated!
            self.timePassedStr = newPassedStr
        } else {
            if forceRefresh {
                self.objectWillChange.send()
            }
        }
        SettingViewModel.floatWindowUpd()
    }
}

extension MainViewModel {
    func updConfig() {
        st.isGoing ? saveIsGoingSettings() : saveStopSettings()
    }
    
    func saveIsGoingSettings() {
        switch Config.shared.saveIsGoingSettings.value {
        case .TimeGoingOnKalaClose:
            Config.shared.appDisableTimeStamp.value = CACurrentMediaTime()
            Config.shared.timePassedInterval.value = st.diff
            NSApplication.shared.terminate(self)
        case .SaveAndClose:
            Config.shared.timePassedInterval.value = st.diff
            Config.shared.appDisableTimeStamp.value = 0
            NSApplication.shared.terminate(self)
        case .NewSessionFromScratch:
            Config.shared.timePassedInterval.value = 0
            Config.shared.appDisableTimeStamp.value = 0
        case .AskAction:
            AppDelegate.instance.showCustomAlert()
        }
    }
    
    func saveStopSettings() {
        switch Config.shared.saveStopSettings.value {
        case .SaveAndClose:
            Config.shared.timePassedInterval.value = st.diff
            Config.shared.appDisableTimeStamp.value = 0
            NSApplication.shared.terminate(self)
        case .NewSessionFromScratch:
            Config.shared.timePassedInterval.value = 0
            Config.shared.appDisableTimeStamp.value = 0
        case .AskAction:
            AppDelegate.instance.showCustomAlert()
        }
    }
}

extension MainViewModel {
    func start() {
        st.start()
        updTimerInterface(forceRefresh: true)
    }
    
    func pause() {
        st.pause()
        updTimerInterface(forceRefresh: true)
    }
    
    func reset() {
        st.reset()
        updTimerInterface(forceRefresh: true)
    }
}

////////////////
///HELPERS
////////////////

extension Stopwatch {
    func twoZeroTime(_ time: Int) -> String{
       let timeArray = String(time)
        if timeArray.count > 1 {
            return "\(timeArray)0".substring(to: 2)
        } else {
             return "0\(timeArray)".substring(to: 2)
        }
    }
    
    var timeStrMs: String {
        let afterDot = (diff - Double(Int(diff)) )
        let ms = Int( afterDot * 1000  )
        let msStr = "\(ms)0000000".substring(to: 3)
        
        return "\(timeStrS).\(msStr)"
    }
    
    var timeStrS: String {
        let sec: Int  = Int(diff.truncatingRemainder(dividingBy: 60.0) )
        let mins: Int = Int( (diff/(60.0)).truncatingRemainder(dividingBy: 60.0) )
        let days: Int = Int( (diff/(60.0*60*24)).truncatingRemainder(dividingBy: 60.0) )
        let hrs: Int  = Int( (diff/(60.0*60)).truncatingRemainder(dividingBy: 60.0) ) - days * 24
        
        if days >= 1 {
            return "\(days)d \(twoZeroTime(hrs)):\(twoZeroTime(mins)):\(twoZeroTime(sec))"
        }
        
        return "\(twoZeroTime(hrs)):\(twoZeroTime(mins)):\(twoZeroTime(sec))"
    }
}

fileprivate extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        
        return (self * multiplier).rounded() / multiplier
    }
}
