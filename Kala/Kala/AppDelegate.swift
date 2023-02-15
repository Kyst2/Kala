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
        guard aboutBoxWindowController == nil else { return}
        
        let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable,/* .resizable,*/ .titled]
        let window = NSWindow()
        window.styleMask = styleMask
        window.title = "About \(Bundle.main.appName)"
        window.contentView = NSHostingView(rootView: AboutView())
        window.center()
        aboutBoxWindowController = NSWindowController(window: window)
        
        aboutBoxWindowController?.showWindow(aboutBoxWindowController?.window)
    }
    
    func showCustomAlert() {
        guard alertWindowController == nil else { return}
        
        let styleMask: NSWindow.StyleMask = [.docModalWindow, .titled ] //[.closable, .miniaturizable,/* .resizable,*/ .titled]
        let window = NSWindow()
        window.styleMask = styleMask
        window.contentView = NSHostingView(rootView: CustomAlertView())
        window.center()
        alertWindowController = NSWindowController(window: window)
        
        alertWindowController?.showWindow(alertWindowController?.window)
    }
    
}
