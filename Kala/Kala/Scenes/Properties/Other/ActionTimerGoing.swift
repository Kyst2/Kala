
import Foundation
import SwiftUI

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
            return "Ask Action"
        case .NewSessionFromScratch:
            return "Reset value to 00.00.00"
        case .SaveAndClose:
            return "Save current session value"
        case .TimeGoingOnKalaClose:
            return "Timer going even if Kala closed"
        }
    }
}
