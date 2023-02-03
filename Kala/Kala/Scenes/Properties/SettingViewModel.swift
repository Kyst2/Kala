import Foundation
import SwiftUI

struct SettingViewModel {
    @ObservedObject var config = Config.shared
    
    func floatWindow() {
        if config.topMost {
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
