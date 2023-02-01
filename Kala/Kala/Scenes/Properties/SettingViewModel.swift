import Foundation
import SwiftUI

struct SettingViewModel {
    @AppStorage("Save_FloatingWindow") var topMost: Bool = false
    
    func floatWindow() {
        if topMost {
            for window in NSApplication.shared.windows {
                window.level = .floating
            }
        }else {
            for window in NSApplication.shared.windows {
                window.level = .normal
            }
        }
    }
}

enum FloatWindow:Int , RawRepresentable , CaseIterable  {
    case float = 0
    case normal = 1
}

extension FloatWindow {
    func asStr() -> LocalizedStringKey {
        switch self {
        case .float:
            return "Да"
        case .normal:
            return "Нет"
        }
    }
}

enum MsYesOrNo: Int , RawRepresentable , CaseIterable {
    case Yes = 0
    case No = 1
}

extension MsYesOrNo {
    func asStr() -> LocalizedStringKey {
        switch self {
        case .Yes:
            return "Да"
        case .No:
            return "Нет"
        }
    }
}
enum ActionTimerStopped: Int, RawRepresentable, CaseIterable {
    case SaveAndClose = 0
    case NewSessionFromScratch = 1
    case AskAction = 9
}

extension ActionTimerStopped {
    func asStr() -> LocalizedStringKey {
        switch self {
        case .AskAction:
            return "Запрашивать что выполнить"
        case .NewSessionFromScratch:
            return "Новая сессия стартует с 00.00.0"
        case .SaveAndClose:
            return "Закрыть с сохранением"
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
            return "Запрашивать что выполнить"
        case .NewSessionFromScratch:
            return "Новая сессия стартует с 00.00.0"
        case .SaveAndClose:
            return "Закрыть с сохранением"
        case .TimeGoingOnKalaClose:
            return "Продолжить измерять время пока Kala закрыта"
        }
    }
}

