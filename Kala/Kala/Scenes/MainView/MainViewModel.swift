import Foundation
import SwiftUI
import QuartzCore

class MainViewModel: ObservableObject {
    @Published var timePassedStr = "00:00.000"
    
    private(set) var timer: Timer!
    private let st = Stopwatch()
    @Published var isGoing: Bool = false
    
    init() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [self] _ in
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
    }
    
    
}



fileprivate extension Stopwatch {
    var timeStr: String {
        let days: Int = Int(diff/(60.0*60*24))
        let hrs: Int = Int(diff/(60.0*60))
        let mins: Int = Int(diff/(60.0))
        let sec: Int = Int(diff.truncatingRemainder(dividingBy: 60.0) )
        let ms: Int = Int( (diff - Double(Int(diff)) ) * 1000.0)
        
        if days >= 1 {
            return "\(days)d \(hrs):\(mins):\(sec).\(ms)"
        }
        
        return "\(hrs):\(mins):\(sec).\(ms)"
    }
}
