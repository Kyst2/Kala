import Foundation
import SwiftUI
import AppKit
import AppCoreLight

struct SettingViewModel {
    static func floatWindowUpd() {//// UKS!!!!!!!!!
        let wndLvl: NSWindow.Level = Config.shared.topMost.value ? .floating : .normal
        
        if wndLvl == .floating {
            for window in NSApplication.shared.windows {
                window.level =  window.title == "Kala" ? wndLvl : wndLvl + 1
            }
        } else {
            for window in NSApplication.shared.windows {
                window.level =  .normal
            }
        }
    }
}
