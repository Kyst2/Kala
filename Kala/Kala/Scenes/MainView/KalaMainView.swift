import SwiftUI
import Foundation
import Combine

struct KalaMainView: View {
    @ObservedObject var model = MainViewModel.shared
    @ObservedObject var config = Config.shared
    
    
    @Environment(\.colorScheme) var theme
    var themeIsDark: Bool { theme == .dark }
    
    var body: some View {
        ZStack {
            VisualEffectView(type:.behindWindow, material: themeIsDark ?  .m6_tooltip : .m1_hudWindow)
            
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
        .onChange(of: config.hourSalary) { _ in MainViewModel.shared.updTimerInterface(forceRefresh: true) }
        .onChange(of: config.displaySalary) { _ in model.updTimerInterface(forceRefresh: true) }
        .onChange(of: config.currency){_ in model.updTimerInterface(forceRefresh: true) }
    }
}

////////////////
///HELPERS
////////////////

fileprivate extension NSWindow {
    @objc
    func doCustomClose(_ sender: Any?) {
        if MainViewModel.shared.st.isGoing {
            switch Config.shared.saveIsGoingSettings {
            case .AskAction:
                AppDelegate.instance.showCustomAlert()
            default:
                MainViewModel.shared.updConfig()
                MainViewModel.shared.st.pause()
                NSApplication.shared.terminate(self)
            }
        } else {
            switch Config.shared.saveStopSettings {
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
}
