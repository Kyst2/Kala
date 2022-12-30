import SwiftUI

// Usage:
//
//    .wndAccessor {
//        $0?.title = String(localized: "All you need to know about FileBo in ONE minute")
//    }

@available(OSX 11.0, *)
public extension View {
    func wndAccessor(_ act: @escaping (NSWindow?) -> () )
        -> some View {
            self.modifier(WndTitleConfigurer(act: act))
    }
}

@available(OSX 11.0, *)
struct WndTitleConfigurer: ViewModifier {
    let act: (NSWindow?) -> ()
    
    @State var window: NSWindow? = nil
    
    func body(content: Content) -> some View {
        content
            .getWindow($window)
            .onChange(of: window, perform: act )
    }
}

//////////////////////////////
///HELPERS
/////////////////////////////

// Don't use this:
// Usage:
//.getWindow($window)
//.onChange(of: window) { _ in
//    if let wnd = window {
//        wnd.level = .floating
//    }
//}

@available(OSX 11.0, *)
private extension View {
    func getWindow(_ wnd: Binding<NSWindow?>) -> some View {
        self.background(WindowAccessor(window: wnd))
    }
}

@available(OSX 11.0, *)
private struct WindowAccessor: NSViewRepresentable {
    @Binding var window: NSWindow?
    
    public func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            self.window = view.window
        }
        return view
    }
    
    public func updateNSView(_ nsView: NSView, context: Context) {}
}
