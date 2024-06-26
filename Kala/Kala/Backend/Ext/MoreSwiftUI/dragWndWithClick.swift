import Foundation
import SwiftUI

@available(OSX 11.0, *)
public extension View {
    func dragWndWithClick() -> some View {
        self.overlay(DragWndView())
    }
}

@available(OSX 11.0, *)
public struct DragWndView: View {
    public let test: Bool
    
    public init(test: Bool = false) {
        self.test = test
    }
    
    public var body: some View {
        ( test ? Color.green : Color.clickableAlpha )
            .overlay( DragWndNSRepr() )
    }
}

///////////////
///HELPERS
///////////////
@available(OSX 11.0, *)
fileprivate struct DragWndNSRepr: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        return DragWndNSView()
    }
    
    func updateNSView(_ nsView: NSView, context: Context) { }
}

fileprivate class DragWndNSView: NSView {
    override public func mouseDown(with event: NSEvent) {
        window?.performDrag(with: event)
    }
}

@available(OSX 10.15, *)
public extension Color {
    static var clickableAlpha: Color { get { return Color(rgbaHex: 0x01010101) } }
}
