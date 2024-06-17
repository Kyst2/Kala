import SwiftUI
import Foundation
import Combine
import AppCoreLight

struct MainView: View {
    @ObservedObject var model = MainViewModel.shared
    
    var config: Config = Config.shared
    
    @Environment(\.colorScheme) var theme
    
    var body: some View {
        ZStack {
            VisualEffectView(type:.behindWindow, material: theme.isDark ?  .m6_tooltip : .m1_hudWindow)
            
            DragWndView()
            
            StopwatchInterfaceView(model: model)
                .padding(EdgeInsets(top: 25, leading: 40, bottom: 25, trailing: 40))
        }
        .ignoresSafeArea()
        .wndAccessor {
            if let wnd = $0 {
                wnd.standardWindowButton(.closeButton)?.action = #selector(NSWindow.doCustomClose(_:))
                
                SettingViewModel.floatWindowUpd()
            }
        }
    }
}

////////////////
///HELPERS
////////////////

fileprivate extension NSWindow {
    @objc
    func doCustomClose(_ sender: Any?) {
        MainViewModel.shared.st.isGoing ? saveIsGoingSettings() : saveStopSettings()
    }
    
    func saveIsGoingSettings() {
        switch Config.shared.saveIsGoingSettings.value {
        case .AskAction:
            AppDelegate.instance.showCustomAlert()
        default:
            MainViewModel.shared.updConfig()
            MainViewModel.shared.st.pause()
            NSApplication.shared.terminate(self)
        }
    }
    
    func saveStopSettings() {
        switch Config.shared.saveStopSettings.value {
        case .AskAction:
            AppDelegate.instance.showCustomAlert()
        case .SaveAndClose :
            MainViewModel.shared.updConfig()
            MainViewModel.shared.pause()
            NSApplication.shared.terminate(self)
        default:
            MainViewModel.shared.updConfig()
            MainViewModel.shared.st.pause()
            NSApplication.shared.terminate(self)
        }
    }
}
