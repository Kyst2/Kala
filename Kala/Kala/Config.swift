import Foundation
import SwiftUI

class Config: ObservableObject {
    static let shared = Config()
    
    private init() { }
    
    @AppStorage("Save_StopSettings") var saveStopSettings: ActionTimerStopped = .AskAction
    @AppStorage("Save_PlaySettings") var saveIsGoingSettings: ActionTimerGoing = .AskAction
    
    @AppStorage("Save_Ms") var displayMs: Bool = false
    @AppStorage("Save_FloatingWindow") var topMost: Bool = false
    
    @AppStorage("Save_Time_Interval") var timePassedInterval: CFTimeInterval = CFTimeInterval()
    
    @AppStorage("Save_isGoing") var isGoing: Bool = false
}

//////////////////////////
///HELPERS
//////////////////////////

enum ActionTimerStopped: Int, RawRepresentable, CaseIterable {
    case SaveAndClose = 0
    case NewSessionFromScratch = 1
    case AskAction = 9
}

extension ActionTimerStopped {
    func asStr() -> LocalizedStringKey {
        switch self {
        case .AskAction:
            return "Ask what to do"
        case .NewSessionFromScratch:
            return "The new session starts at 00.00.0"
        case .SaveAndClose:
            return "Close with save"
        }
    }
}

enum ActionTimerGoing: Int, RawRepresentable, CaseIterable {
    case SaveAndClose = 0
    case NewSessionFromScratch = 1
    case AskAction = 2
    case TimeGoingOnKalaClose = 3
}

extension ActionTimerGoing {
    func asStr() -> LocalizedStringKey {
        switch self {
        case .AskAction:
            return "Ask what to do"
        case .NewSessionFromScratch:
            return "The new session starts at 00.00.0"
        case .SaveAndClose:
            return "Close with save"
        case .TimeGoingOnKalaClose:
            return "Continue to measure time while Kala is closed"
        }
    }
}
