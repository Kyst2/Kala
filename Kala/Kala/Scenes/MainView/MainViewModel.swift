import Foundation
import SwiftUI
import QuartzCore

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var timePassedStr: String
    @Published var salaryTime: Bool = Config.shared.displaySalary
    var config = Config.shared
    
    var salary: String = "0.00"
    
    private(set) var timer: Timer!
    let st = Stopwatch(startTime: nil)
    var counter = 0
    
    private init() {
        self.timePassedStr = Config.shared.displayMs ? self.st.timeStrMs : self.st.timeStrS
        self.salaryTime = Config.shared.displaySalary ? false : true
        
        if let appDisableTimeStamp = config.appDisableTimeStamp, config.saveIsGoingSettings == .TimeGoingOnKalaClose || config.saveIsGoingSettings == .AskAction  {
            st.setDiffOffline(CACurrentMediaTime() - appDisableTimeStamp)
            start()
        }
        
        if config.timePassedInterval > 0 {
            st.setDiff(config.timePassedInterval)
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.09, repeats: true, block: { [self] _ in
            updTimerInterface()
            ///hack to save at least some user data in case of PC is rebooted unexpectedly or in case of Force Quit was initiated
            counter += 1
            if counter > 100 {
                config.timePassedInterval = st.diff
                counter = 0
            }
        } )
    }
    
    func updTimerInterface(forceRefresh: Bool = false) {
        let newPassedStr = Config.shared.displayMs ? self.st.timeStrMs : self.st.timeStrS
        let salaryDouble = (self.st.diff/3600 * config.hourSalary).rounded(digits: 2)
        self.salary = "\( String(format: "%.2f", salaryDouble))"
        if self.timePassedStr != newPassedStr {
            // Must be first before timePassedStr change to be updated!
            self.timePassedStr = newPassedStr
        } else {
            if forceRefresh {
                self.objectWillChange.send()
            }
        }
    }
    
    func updConfig() {
        if st.isGoing {
            switch config.saveIsGoingSettings {
            case .TimeGoingOnKalaClose:
                config.appDisableTimeStamp = CACurrentMediaTime()
                config.timePassedInterval = st.diff
                NSApplication.shared.terminate(self)
            case .SaveAndClose:
                config.timePassedInterval = st.diff
                config.appDisableTimeStamp = nil
                NSApplication.shared.terminate(self)
                
            case .NewSessionFromScratch:
                config.timePassedInterval = 0
                config.appDisableTimeStamp = nil
            case .AskAction:
                AppDelegate.instance.showCustomAlert()
            }
        } else {
            switch config.saveStopSettings {
            case .SaveAndClose:
                config.timePassedInterval = st.diff
                config.appDisableTimeStamp = nil
                NSApplication.shared.terminate(self)
            case .NewSessionFromScratch:
                config.timePassedInterval = 0
                config.appDisableTimeStamp = nil
            case .AskAction:
                AppDelegate.instance.showCustomAlert()
            }
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
