import SwiftUI

@main
struct KalaApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            KalaMainView()
        }
        .windowStyle(.hiddenTitleBar)
        .removeUselessMenus()
        .replaceAbout()
        
        Settings {
            SettingView()
        }.windowStyle(.hiddenTitleBar)
    }
}

/////////////////////
///HELPERS
////////////////////

fileprivate extension Scene {
    func replaceAbout() -> some Scene {
        self.commands {
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button("About \(Bundle.main.appName)") { AppDelegate.instance.showAboutWnd() }
            }
        }
    }
    
    @SceneBuilder
    func removeUselessMenus() -> some Scene {
        self.commands {
            CommandGroup(replacing: .newItem, addition: { })
            CommandGroup(replacing: .undoRedo, addition: { })
            CommandGroup(replacing: .toolbar, addition: { })
            CommandGroup(replacing: .windowList, addition: { })
            CommandGroup(replacing: .pasteboard, addition: { })
            CommandGroup(replacing: .windowSize, addition: { })
            CommandGroup(replacing: .appInfo, addition: { })
            CommandGroup(replacing: .help, addition: { })
            CommandGroup(replacing: .appTermination, addition: { })
            CommandGroup(replacing: .appVisibility, addition: { })
        }
    }
}
