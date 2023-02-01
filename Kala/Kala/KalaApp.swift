import SwiftUI

@main
struct KalaApp: App {
    static var mainVm = MainViewModel()
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            KalaMainView(model: KalaApp.mainVm)
                .onAppear{
                    
                if Config.shared.saveIsGoingSettings == .TimeGoingOnKalaClose {
                    if KalaApp.mainVm.isGoing == true {
                    KalaApp.mainVm.start()
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
