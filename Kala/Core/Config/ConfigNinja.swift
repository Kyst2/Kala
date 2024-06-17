import AppCoreLight
import Foundation
import AsyncNinja
import SwiftUI

class Config: NinjaContext.Main {
    static var shared: Config = initSharedConfig()
    
    var appDisableTimeStamp : ConfigProperty<CFTimeInterval>//!!!!
    
    var saveStopSettings    : ConfigPropertyEnum<ActionTimerStopped>
    var saveIsGoingSettings : ConfigPropertyEnum<ActionTimerGoing>
    
    var topMost             : ConfigProperty<Bool>
    var displayMs           : ConfigProperty<Bool>
    var timePassedInterval  : ConfigProperty<CFTimeInterval> //!!!!!
    
    var displaySalary       : ConfigProperty<Bool>
    var hourSalary          : ConfigProperty<Double>
    var currency            : ConfigPropertyEnum<Currency>

    init(store: ConfigBackend) {
        appDisableTimeStamp      = store.property(key: "appDisableTimeStamp", defaultValue: 0)
        
        saveStopSettings         = store.propertyEnumRepresentable(key: "saveStopSetings", defaultValue: .AskAction)
        saveIsGoingSettings      = store.propertyEnumRepresentable(key: "saveIsGoingSettings", defaultValue: .AskAction)
        
        topMost                  = store.property(key: "topMost", defaultValue: false)
        timePassedInterval       = store.property(key: "timePassedInterval", defaultValue: CFTimeInterval())
        displayMs                = store.property(key: "displayMs", defaultValue: false)
        
        displaySalary            = store.property(key: "displaySalary", defaultValue: false)
        hourSalary               = store.property(key: "hourSalary", defaultValue: 0)
        currency                 = store.propertyEnumRepresentable(key: "currency", defaultValue: .usd)
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



