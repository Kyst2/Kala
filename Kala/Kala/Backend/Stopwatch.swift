import Foundation
import SwiftUI
import QuartzCore

public class Stopwatch {
    var startTime: CFTimeInterval?
    
    var offlinetTime: CFTimeInterval?
    
    public var isGoing: Bool = false
    
    private var memoredTime: CFTimeInterval?
    var diff: CFTimeInterval {
        guard let startTime = self.startTime else { return (memoredTime ?? 0) }
        
        let endTime = CACurrentMediaTime()
        return endTime - startTime + (memoredTime ?? 0) + (offlinetTime ?? 0)
    }
    
    public init (startTime: CFTimeInterval?) {
        self.startTime = startTime
    }
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
        memoredTime = nil
        startTime = CACurrentMediaTime()
    }
    
    func reset() {
        isGoing = false
        memoredTime = nil
        startTime = nil
    }
    
    func pause() {
        isGoing = false
        
        if let _ = self.memoredTime {
            self.memoredTime = diff
        } else {
            self.memoredTime = diff
        }
        offlinetTime = nil
        startTime = nil 
    }
    
    func setDiff(_ interval: CFTimeInterval) {
        self.memoredTime = interval
    }
    func setDiffOffline(_ interval: CFTimeInterval) {
        self.offlinetTime = interval
    }
}
