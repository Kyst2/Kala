import Foundation
import SwiftUI
import QuartzCore

class MainViewModel: ObservableObject {
    @Published var timePassedStr: String = "0:0:0.0"
    @AppStorage("Save_Time_Interval") var timePassedInterval: CFTimeInterval = CFTimeInterval()
    @AppStorage("Save_Bool") var isGoing: Bool = false
    private(set) var timer: Timer!
     let st = Stopwatch()
    
    
    init() {
        if timePassedInterval > 0 {
            st.setDiff(timePassedInterval)
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [self] _ in
            self.timePassedInterval = self.st.diff
            self.timePassedStr = self.st.timeStr
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
    var timeStr: String {
        let days: Int = Int(diff/(60.0*60*24))
        let hrs: Int = Int(diff/(60.0*60))
        let mins: Int = Int(diff/(60.0))
        let sec: Int = Int(diff.truncatingRemainder(dividingBy: 60.0) )
        let ms: Int = Int( (diff - Double(Int(diff)) ) * 10.0)
        
        if days >= 1 {
            return "\(days)d \(hrs):\(mins):\(sec).\(ms)"
        }
        
        return "\(hrs):\(mins):\(sec).\(ms)"
    }
}
