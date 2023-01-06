import Foundation
import CoreFoundation

@available(macOS 10.15, *)
public class StopwatchUKS {
    public var elapsedS : Double {
        guard let startTime = startTime else { return 0 }
        
        if isGoing {
            return (CFAbsoluteTimeGetCurrent() - startTime )
        } else if let endTime = endTime {
            return (endTime - startTime)
        }
        
        return 0
    }
    
    public var elapsedMs: Double {
        return elapsedS * 1000
    }
    
    private var startTime : CFAbsoluteTime? = nil
    private var endTime : CFAbsoluteTime? = nil
    private var isGoing = false
    
    public init () { }
    
    public func start(_ str : String? = nil) -> StopwatchUKS {
        if let str = str {
            print(str)
        }
        
        if startTime == nil {
            startTime = CFAbsoluteTimeGetCurrent()
            isGoing = true
            return self
        }
        
        isGoing = true
        return self
    }
    
    public func restart(_ str : String? = nil) -> StopwatchUKS {
        startTime = nil
        return start(str)
    }
    
    public func stop() {
        endTime = CFAbsoluteTimeGetCurrent()
        isGoing = false
    }
    
    public func reset() {
        startTime = nil
        endTime = nil
        isGoing = false
    }
    
    public func printS(_ str : String? = nil) {
        print( str == nil ? "\(elapsedS) sec" : "\(str!): \(elapsedS) sec")
    }
    
    public func printMs(_ str : String? = nil){
        print( str == nil ? "\(elapsedS) ms" : "\(str!): \(elapsedMs) ms")
    }
}

///////////////////
/// OTHER | Garbage
//////////////////

public extension TimeInterval {
    var msVal: Double {
        return truncatingRemainder(dividingBy: 1) * 1000
    }
    
    var secVal: Int {
        return Int(self) % 60
    }
    
    var minsVal: Int {
        return (Int(self) / 60 ) % 60
    }
    
    var hoursVal: Int {
        return Int(self) / 3600
    }
    
    var secTotal: Int {
        Int(self)
    }
    
    var minsTotal: Int {
        Int(self)/60
    }
    
    var minsTotalAbs: Int {
        abs( Int(self)/60 )
    }
    
    var secTotalAbs: Int {
        abs( Int(self) )
    }
}

public extension TimeInterval{
    func asStr() -> String {
        var formatString: String
        
        if hoursVal == 0 {
            if (minsVal < 10) {
                formatString = "%2d:%0.2d"
            } else {
                formatString = "%0.2d:%0.2d"
            }
            
            return String(format: formatString, minsVal, secVal)
        } else {
            formatString = "%2d:%0.2d:%0.2d"
            return String(format: formatString, hoursVal, minsVal, secVal)
        }
    }
}

public extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
