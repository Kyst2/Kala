import SwiftUI

@main
struct KalaApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            KalaMainView()
                .onAppear{
                if Config.shared.saveIsGoingSettings == .TimeGoingOnKalaClose {
                    if Config.isGoing == true {
                        MainViewModel.shared.start()
                    }
                }
            }
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
