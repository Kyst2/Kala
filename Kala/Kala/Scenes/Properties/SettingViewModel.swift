import Foundation
import SwiftUI

struct SettingViewModel {
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

