import Foundation
import SwiftUI

struct NeuromorphBtn: View {
    let text: LocalizedStringKey
    let action: () -> ()
    
    @Environment(\.colorScheme) var theme
    
    init (_ text: LocalizedStringKey, action: @escaping () -> ()) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: { action() } ) {
            Text(text)
                .padding(.horizontal, 30)
                .font(.system(size: 20,design: .monospaced))
                .foregroundColor( theme == .dark ? .gray : .gray)
                .fixedSize()
        }
        .buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 20)))
    }
}

extension View {
    func NeumorphicStyle() -> some View {
        self.padding(30)
            .frame(maxWidth: .infinity)
            //.background(Color.offWhite)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

struct NeumorphicButton<S: Shape>: ButtonStyle {
    var shape: S
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(15)
            .background(Background(isPressed: configuration.isPressed, shape: shape))
    }
}

struct Background<S: Shape>: View {
    var isPressed: Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isPressed {
                shape
                    //.fill(Color.offWhite)
                    .overlay(
                        shape
                            .stroke(Color.gray, lineWidth: 3)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(shape.fill(LinearGradient(colors: [Color.black, Color.clear], startPoint: .center, endPoint: .center)))
                    )
                    .overlay(
                        shape
                            .stroke(Color.white, lineWidth: 3)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask(shape.fill(LinearGradient(colors: [Color.black, Color.clear], startPoint: .center, endPoint: .center)))
                    )
            }
                        else {
                shape
                    //.fill(Color.offWhite)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            }
        }
    }
}
