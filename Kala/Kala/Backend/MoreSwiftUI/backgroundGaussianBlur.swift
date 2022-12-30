import Foundation
import SwiftUI
import Combine

@available(OSX 11.0, *)
public extension View {
    func backgroundGaussianBlur(type: NSVisualEffectView.BlendingMode = .withinWindow, material: GausianMaterial = .m1_hudWindow) -> some View {
        self.background( VisualEffectView(type: type, material: material) )
    }
}
@available(OSX 10.15, *)
public struct VisualEffectView: NSViewRepresentable {
    let type: NSVisualEffectView.BlendingMode
    let material: GausianMaterial
    
    public init(type: NSVisualEffectView.BlendingMode = .withinWindow, material: GausianMaterial = .m1_hudWindow) {
        self.type = type
        self.material = material
    }
    
    public func makeNSView(context: Context) -> NSVisualEffectView {
        NSVisualEffectView()
    }
    
    public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.blendingMode = type
        nsView.state = .active
        
        switch material {
        case .m1_hudWindow:
            nsView.material = .hudWindow
        case .m2_menu:
            nsView.material = .menu
        case .m3_selection:
            nsView.material = .selection
        case .m4_headerView:
            nsView.material = .headerView
        case .m5_sidebar:
            nsView.material = .sidebar
        case .m6_tooltip:
            nsView.material = .toolTip
        }
    }
    
    public typealias NSViewType = NSVisualEffectView
}

public enum GausianMaterial {
    case m1_hudWindow
    case m2_menu
    case m3_selection
    case m4_headerView
    case m5_sidebar
    case m6_tooltip
}

