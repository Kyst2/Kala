import Foundation
import SwiftUI
import QuartzCore

public class Stopwatch {
    public var isGoing: Bool = false
    
    private var startTime : CFTimeInterval?
    private var memoredTime: CFTimeInterval?
    
    var diff: CFTimeInterval {
        guard let startTime = startTime else { return 0 }
        
        let endTime = CACurrentMediaTime()
        return endTime - startTime  + (memoredTime ?? 0)
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
        startTime = CACurrentMediaTime()
        return self
    }
    
    func restart() {
        isGoing = true
        startTime = CACurrentMediaTime()
        memoredTime = nil
    }
    
    func reset() {
        isGoing = false
        startTime = nil
        memoredTime = nil
    }
    
    func pause() {
        isGoing = false
        
        if let _ = self.memoredTime {
            self.memoredTime! = diff
        } else {
            self.memoredTime = diff
        }
    }
}
