import Foundation
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    static private(set) var instance: AppDelegate! = nil
    
    var aboutBoxWindowController: NSWindowController?
    var alertWindowController: NSWindowController?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        AppDelegate.instance = self
    }
    
    func showAboutWnd() {
        if aboutBoxWindowController == nil {
            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable,/* .resizable,*/ .titled]
            let window = NSWindow()
            window.styleMask = styleMask
            window.title = "About \(Bundle.main.appName)"
            window.contentView = NSHostingView(rootView: AboutView())
            window.center()
            
            aboutBoxWindowController = NSWindowController(window: window)
        }
        
        aboutBoxWindowController?.showWindow(aboutBoxWindowController?.window)
        aboutBoxWindowController?.window?.moveTo(screen: mainWnd()?.screen)
        
        SettingViewModel.floatWindowUpd()
    }
    
    func mainWnd() -> NSWindow? {
        NSApplication.shared.windows.filter{ $0.title == "Kala" }.first
    }
    
    func showCustomAlert() {
        if alertWindowController == nil {
            let styleMask: NSWindow.StyleMask = [.docModalWindow, .titled ] //[.closable, .miniaturizable,/* .resizable,*/ .titled]
            let window = NSWindow()
            window.styleMask = styleMask
            window.contentView = NSHostingView(rootView: CustomAlertView())
            window.center()
            alertWindowController = NSWindowController(window: window)
        }
        
        alertWindowController?.showWindow(alertWindowController?.window)
        alertWindowController?.window?.moveTo(screen: mainWnd()?.screen)
        
        SettingViewModel.floatWindowUpd()
    }
}
