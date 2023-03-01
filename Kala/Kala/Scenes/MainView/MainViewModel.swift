import Foundation
import SwiftUI
import QuartzCore

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var timePassedStr: String = "00:00:00.000"
    @ObservedObject var config = Config.shared
    
    var salary: String = ""
    
    private(set) var timer: Timer!
    let st = Stopwatch(startTime: nil)
    
    private init() {
        if let appDisableTimeStamp = config.appDisableTimeStamp, config.saveIsGoingSettings == .TimeGoingOnKalaClose {
            st.setDiffOffline(CACurrentMediaTime() - appDisableTimeStamp)
//            st.setDiff(appDisableTimeStamp)
            start()
        }
        
        if config.timePassedInterval > 0 {
            st.setDiff(config.timePassedInterval)
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.09, repeats: true, block: { [self] _ in
            let salaryDouble = (self.st.diff/3600 * config.hourSalary).rounded(digits: 2)
            self.salary = "[\( String(format: "%.2f", salaryDouble) )$]"
            
            let newPassedStr = config.displayMs ? self.st.timeStrMs : self.st.timeStrS
            
            if self.timePassedStr != newPassedStr {
                self.timePassedStr = newPassedStr
            }
        } )
        
    }
    
    func start() {
        st.start()
    }
    
    func pause() {
        st.pause()
        
        self.objectWillChange.send()
    }
    
    func reset() {
        if config.displayMs == true {
            timePassedStr = "00:00:00.000"
        }else {
            timePassedStr = "00:00:00"
        }
        
        st.reset()
        
        self.objectWillChange.send()
    }
    
    func copyToClipBoard(textToCopy: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(textToCopy, forType: .string)
    }
    
    func updConfig() {
        if st.isGoing {
            switch config.saveIsGoingSettings {
            case .TimeGoingOnKalaClose:
                config.appDisableTimeStamp = CACurrentMediaTime()
                config.timePassedInterval = st.diff
                break
            case .SaveAndClose:
                config.timePassedInterval = st.diff
                config.appDisableTimeStamp = nil
                NSApplication.shared.terminate(self)
            default:
                config.timePassedInterval = 0
                config.appDisableTimeStamp = nil
            }
        } else {
            switch config.saveStopSettings {
            case .SaveAndClose:
                config.timePassedInterval = st.diff
                config.appDisableTimeStamp = nil
                NSApplication.shared.terminate(self)
            default:
                config.timePassedInterval = 0
                config.appDisableTimeStamp = nil
            }
        }
    }
}

extension Stopwatch {
    func twoZeroTime(_ time: Int) -> String{
       let timeArray = String(time)
        if timeArray.count > 1 {
            return "\(timeArray)0".substring(to: 2)
        }else {
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

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        
        return (self * multiplier).rounded() / multiplier
    }
}
