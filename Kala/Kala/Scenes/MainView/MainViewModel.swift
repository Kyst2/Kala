import Foundation
import SwiftUI
import QuartzCore

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var timePassedStr: String = "00:00:00.000"
    @ObservedObject var config = Config.shared
    
    var salary: String = ""
    
    private(set) var timer: Timer!
    let st = Stopwatch()
    
    private init() {
        SettingViewModel.floatWindowUpd()
        
        if config.timePassedInterval > 0 {
            st.setDiff(config.timePassedInterval)
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [self] _ in
            self.config.timePassedInterval = self.st.diff
            
            let sry = (self.st.diff/3600 * config.hourSalary).rounded(digits: 2)
            self.salary = "[\( String(format: "%.2f", sry) )$]" 
            
            self.timePassedStr = config.displayMs ? self.st.timeStrMs : self.st.timeStrS
        } )
    }
    
    func start() {
        config.isGoing = true
        st.start()
    }
    
    func pause() {
        config.isGoing = false
        st.pause()
    }
    
    func reset() {
        config.isGoing = false
        st.reset()
        
        timePassedStr = "00:00:00.000"
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
