import Foundation
import SwiftUI

@available(OSX 11.0, *)
public extension View {
    func takeAllAvailableSpace() -> some View
    {
         self
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity
                )
    }
    
    func fillParent() -> some View {
        self.takeAllAvailableSpace()
    }
}
