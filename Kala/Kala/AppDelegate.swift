import Foundation
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var aboutBoxWindowController: NSWindowController?
    
    func showCustomAlert() {
        let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable,/* .resizable,*/ .titled]
        let window = NSWindow()
        window.styleMask = styleMask
        window.title = "CustomAlert \(Bundle.main.appName)"
        window.contentView = NSHostingView(rootView: CustomAlertView())
        window.center()
        aboutBoxWindowController = NSWindowController(window: window)
    }
}
