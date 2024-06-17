
import Foundation
import SwiftUI

enum ActionTimerStopped: Int, RawRepresentable, CaseIterable {
    case SaveAndClose = 0
    case NewSessionFromScratch = 1
    case AskAction = 9
}

extension ActionTimerStopped {
    func asStr() -> LocalizedStringKey {
        switch self {
        case .AskAction:
            return "Ask Action"
        case .NewSessionFromScratch:
            return "Reset value to 00.00.00"
        case .SaveAndClose:
            return "Save current session value"
        }
    }
}
