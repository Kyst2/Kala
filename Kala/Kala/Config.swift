import Foundation
import SwiftUI
import Combine

class Config: ObservableObject {
    static let shared = Config()
    
    private var cancellable: AnyCancellable?
    
    private init() {
        cancellable = self.objectWillChange.sink { _ in
            SettingViewModel.floatWindowUpd()
        }
    }
    
    // needed for measure time of app disable period
    @AppStorage("Save_AppDisableTimeStamp") var appDisableTimeStamp: CFTimeInterval?
    
    @AppStorage("Save_StopSettings") var saveStopSettings: ActionTimerStopped = .AskAction
    @AppStorage("Save_PlaySettings") var saveIsGoingSettings: ActionTimerGoing = .AskAction
    
    @AppStorage("Save_Ms") var displayMs: Bool = false
    @AppStorage("Save_FloatingWindow") var topMost: Bool = false
    
    @AppStorage("Save_Time_Interval") var timePassedInterval: CFTimeInterval = CFTimeInterval()
    
    @AppStorage("Save_displayMoney") var displaySalary: Bool = false
    @AppStorage("Save_hourSalary") var hourSalary: Double = 0
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
            return "Ask Action"
        case .NewSessionFromScratch:
            return "Reset value to 00.00.00"
        case .SaveAndClose:
            return "Save current session value"
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
