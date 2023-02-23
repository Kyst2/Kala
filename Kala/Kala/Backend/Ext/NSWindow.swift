import Foundation
import SwiftUI

extension NSWindow {
    func moveTo(screen: NSScreen?) {
        guard let screen = screen else { return }
        
        DispatchQueue.main.async {
             var pos = NSPoint()
             pos.x = screen.visibleFrame.midX
             pos.y = screen.visibleFrame.midY
             self.setFrameOrigin(pos)
         }
    }
}
