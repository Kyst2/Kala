import Foundation
import SwiftUI
import QuartzCore

public class Stopwatch {
//    var startTime:CFTimeInterval? = Config.shared.saveStarttime
    
    
    public var isGoing: Bool = false
    
    private var memoredTime: CFTimeInterval?
    var diff: CFTimeInterval {
        guard let startTime = Config.shared.saveStarttime else { return (memoredTime ?? 0) }
        
        let endTime = CACurrentMediaTime()
        return endTime - startTime + (memoredTime ?? 0)
    }
    
    public init () { }
}

public extension Stopwatch {
    @discardableResult
    func start() -> Stopwatch {
        if isGoing {
            return self
        }
        isGoing = true
        if Config.shared.saveStarttime == nil {
           Config.shared.saveStarttime = CACurrentMediaTime()
        }
        return self
    }
    
    func restart() {
        isGoing = true
        Config.shared.saveStarttime = CACurrentMediaTime()
        memoredTime = nil
    }
    
    func reset() {
        isGoing = false
        Config.shared.saveStarttime = nil
        memoredTime = nil
    }
    
    func pause() {
        isGoing = false
        
        if let _ = self.memoredTime {
            self.memoredTime = diff
        }else {
            self.memoredTime = diff
        }
        
        Config.shared.saveStarttime = nil
    }
    
    func setDiff(_ interval: CFTimeInterval) {
        self.memoredTime = interval
    }
    
    func offline() {
        if let _ = self.memoredTime {
            self.memoredTime = diff
        }else {
            self.memoredTime = diff
        }
        Config.shared.saveStarttime = CACurrentMediaTime()
    }
}
