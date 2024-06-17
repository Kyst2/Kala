import AppCoreLight
import Foundation
import AsyncNinja
import SwiftUI

class Config: NinjaContext.Main {
    static var shared: Config = initSharedConfig()
    
    var appDisableTimeStamp : ConfigProperty<CFTimeInterval>
    var saveStopSettings    : ConfigPropertyEnum<ActionTimerStopped>
    var saveIsGoingSettings : ConfigPropertyEnum<ActionTimerGoing>
    var currency            : ConfigPropertyEnum<CurrencyEnum>
    var displayMs           : ConfigProperty<Bool>
    var topMost             : ConfigProperty<Bool>
    var timePassedInterval  : ConfigProperty<CFTimeInterval>
    var displaySalary       : ConfigProperty<Bool>
    var hourSalary          : ConfigProperty<Double>

    init(store: ConfigBackend) {
        appDisableTimeStamp      = store.property(key: "appDisableTimeStamp", defaultValue: 0)
        saveStopSettings         = store.propertyEnumRepresentable(key: "saveStopSetings", defaultValue: .AskAction)
        saveIsGoingSettings      = store.propertyEnumRepresentable(key: "saveIsGoingSettings", defaultValue: .AskAction)
        currency                 = store.propertyEnumRepresentable(key: "currency", defaultValue: .usd)
        displayMs                = store.property(key: "displayMs", defaultValue: false)
        topMost                  = store.property(key: "topMost", defaultValue: false)
        timePassedInterval       = store.property(key: "timePassedInterval", defaultValue: CFTimeInterval())
        displaySalary            = store.property(key: "displaySalary", defaultValue: false)
        hourSalary               = store.property(key: "hourSalary", defaultValue: 0)
    }
}


////////////////////////
///HELPERS
///////////////////////

fileprivate func initSharedConfig() -> Config {
    let se: ServiceEnvironment = .Release
    let cud = ConfigUserDefaults(env: se)
    
    return Config(store: cud)
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

enum CurrencyEnum: Int, RawRepresentable, CaseIterable {
    case usd = 0
    case uah = 1
    case eur = 2
    case gbp = 3
    case cny = 4
    case mnt = 5
    case kzt = 6
}
extension CurrencyEnum {
    func asStr() -> String {
        switch self {
        case .usd:
            return "$"
        case .uah:
            return "₴"
        case .eur:
            return "€"
        case .gbp:
            return "£"
        case .cny:
            return "¥"
        case .mnt:
            return "₮"
        case .kzt:
            return "₸"
            
        }
    }
}
