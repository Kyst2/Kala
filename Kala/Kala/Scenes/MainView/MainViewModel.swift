import Foundation
import SwiftUI
import QuartzCore

class MainViewModel: ObservableObject {
    @Published var timePassedStr: String = "0:0:0.0"
    @AppStorage("Save_Time_Interval") var timePassedInterval: CFTimeInterval = CFTimeInterval()
    @AppStorage("Save_Bool") var isGoing: Bool = false
    @AppStorage("Save_Ms") var displayMs: Bool = false
    
    private(set) var timer: Timer!
    let st = Stopwatch()
    
    init() {
        if timePassedInterval > 0 {
            st.setDiff(timePassedInterval)
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [self] _ in
            self.timePassedInterval = self.st.diff
            
            self.timePassedStr = displayMs ? self.st.timeStrMs : self.st.timeStrS
            
            SettingViewModel().floatWindow()
        } )
    }
    
    func start() {
        isGoing = true
        st.start()
    }
    
    func pause() {
        isGoing = false
        st.pause()
    }
    
    func reset() {
        isGoing = false
        st.reset()
        
        timePassedStr = "0:0:0.0"
    }
}

fileprivate extension Stopwatch {
    var timeStrMs: String {
        let afterDot = (diff - Double(Int(diff)) )
        let ms = Int( afterDot * 1000  )
        let msStr = "\(ms)0000000".substring(to: 3)
        
        return "\(timeStrS).\(msStr)"
    }
    
    var timeStrS: String {
        let days: Int = Int(diff/(60.0*60*24))
        let hrs: Int = Int(diff/(60.0*60))
        let mins: Int = Int(diff/(60.0))
        let sec: Int = Int(diff.truncatingRemainder(dividingBy: 60.0) )
        
        if days >= 1 {
            return "\(days)d \(hrs):\(mins):\(sec)"
        }
        
        return "\(hrs):\(mins):\(sec)"
    }
}

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        
        return (self * multiplier).rounded() / multiplier
    }
}
