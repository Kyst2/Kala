import Foundation
import SwiftUI

struct SettingViewModel {
    static func floatWindowUpd() {
        if Config.shared.topMost {
            for window in NSApplication.shared.windows {
                window.level = .floating
            }
        } else {
            for window in NSApplication.shared.windows {
                window.level = .normal
            }
        }
    }
}
