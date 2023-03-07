//
//  AboutView.swift
//  Kala
//
//  Created by Andrew Kuzmich on 11.01.2023.
//
import Foundation
import SwiftUI

struct AboutView: View {
    
    @Environment(\.colorScheme) var theme
    var themeIsDark: Bool { theme == .dark}
    
    var body: some View {
        ZStack{
            VisualEffectView(type:.behindWindow, material: themeIsDark ?  .m6_tooltip : .m1_hudWindow)
            
            DragWndView()
            VStack(spacing: 10) {
                Image(nsImage: NSImage(named: "kek")!)
                    .dragWndWithClick()
                
                Text("\(Bundle.main.appName)")
                    .font(.system(size: 20, weight: .bold))
                // Xcode 13.0 beta 2
                    .textSelection(.enabled)
                
                Text("Ver: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild)) ")
                // Xcode 13.0 beta 2
                    .textSelection(.enabled)
                
                Text("Copyright (c): \(Bundle.main.copyright)")
                    .font(.system(size: 10, weight: .thin))
                    .multilineTextAlignment(.center)
            }
            .padding(20)
            .frame(minWidth: 350, minHeight: 300)
        }.ignoresSafeArea()
    }
}

///////////////////////////////////
/// HELPERS
//////////////////////////////////
extension AboutView {
    private static var offSiteAdr: String { "http://www.taogit.com" }
    private static var offEmail: String { "someUser@gmail.com" }
    
    public static var offCiteUrl: URL { URL(string: AboutView.offSiteAdr )! }
    public static var offEmailUrl: URL { URL(string: "mailto:\(AboutView.offEmail)")! }
}

extension Bundle {
    public var appName: String { getInfo("CFBundleName")  }
    //public var displayName: String {getInfo("CFBundleDisplayName")}
    //public var language: String {getInfo("CFBundleDevelopmentRegion")}
    //public var identifier: String {getInfo("CFBundleIdentifier")}
    public var copyright: String {getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n")}
    
    public var appBuild: String { getInfo("CFBundleVersion") }
    public var appVersionLong: String { getInfo("CFBundleShortVersionString") }
    //public var appVersionShort: String { getInfo("CFBundleShortVersion") }
    
    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
