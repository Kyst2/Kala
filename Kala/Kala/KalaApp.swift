import SwiftUI

@main
struct KalaApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            KalaMainView()
                .onAppear {
                    if Config.shared.saveIsGoingSettings == .TimeGoingOnKalaClose {
                        if Config.shared.isGoing == true {
                            MainViewModel.shared.start()
                        }
                    }
                }
        }
        .commands {
            
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
//            CommandGroup(replacing: .sidebar, addition: { })
//            CommandGroup(replacing: .printItem, addition: { })
            
        }
        .replaceAbout { appDelegate.showAboutWnd() }
        
        Settings {
            SettingView()
        }
    }
}

/////////////////////
///HELPERS
////////////////////

extension Scene {
    func replaceAbout(act: @escaping () -> () ) -> some Scene {
        self.commands {
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button("About \(Bundle.main.appName)") { act() }
            }
        }
    }
}
