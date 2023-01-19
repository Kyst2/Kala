import SwiftUI

@main
struct KalaApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            KalaMainView()
        }.commands {
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button("About \(Bundle.main.appName)") { appDelegate.showAboutWnd() }
            }
        }
        Settings {
            PropertiesView()
                .background(Color.offWhite)
                .frame(width: 400, height: 400, alignment: .center)
        }
    }
}
