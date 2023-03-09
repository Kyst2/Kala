import Foundation
import SwiftUI
import AppKit

struct SettingViewModel {
    static func floatWindowUpd() {
        let wndLvl: NSWindow.Level = Config.shared.topMost ? .floating : .normal
        if wndLvl == .floating {
            for window in NSApplication.shared.windows {
                window.level =  window.title == "Kala" ? wndLvl : wndLvl + 1
            }
        }else {
            for window in NSApplication.shared.windows {
                window.level =  .normal
            }
        }
        
    }
}
