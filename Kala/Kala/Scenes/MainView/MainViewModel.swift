import Foundation
import SwiftUI
import QuartzCore

class MainViewModel: ObservableObject {
    @AppStorage("Save_Time") var timePassedStr = "0:0:0.000"
    
    private(set) var timer: Timer!
    private let st = Stopwatch()
    @Published var isGoing: Bool = false
    
    init() {
    }
    
    func start() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [self] _ in
            self.timePassedStr = self.st.timeStr
        } )
        isGoing = true
        st.start()
    }
    
    func pause() {
        isGoing = false
        st.pause()
        timer.invalidate()
    }
    
    func reset() {
        isGoing = false
        st.reset()
        if timer == nil {
            
        }else {
            timer.invalidate()
        }
        
        timePassedStr = "0:0:0.000"
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
