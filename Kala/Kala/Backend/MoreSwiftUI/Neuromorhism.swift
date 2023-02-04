import Foundation
import SwiftUI

extension Color {
    init(hex hexColor: UInt32) {
        self.init(red: Double(0xFF & (hexColor >> 0x10)) / 0xFF,
                  green: Double(0xFF & (hexColor >> 0x08)) / 0xFF,
                  blue: Double(0xFF & (hexColor >> 0x00)) / 0xFF)
    }
}


struct NeuButtonBackgroundView : View  {
    let cornerRadius : CGFloat
    let opacity : CGFloat
    let opacityOp : CGFloat
    let shadowRadiusXY : CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    let lThemeLightShadow: Color = Color(hex: 0x888888)
    let lThemeDarkShadow: Color =  Color(hex: 0x555555)
    let dThemeLightShadow: Color = Color(hex: 0x888888)
    let dThemeDarkShadow: Color =  Color(hex: 0x555555)
    
    var mainColor: Color   { colorScheme == .light ? Color.white : Color.darkGray }
    var lightShadow: Color { colorScheme == .light ? lThemeLightShadow : lThemeDarkShadow }
    var darkShadow: Color  { colorScheme == .light ? dThemeLightShadow : dThemeDarkShadow }
    
    var body: some View {
        ZStack {
            ShapeAndColor()
            
            ButtonsDardEdge()
            
            ButtonsInnerDarkShadow()
            
            ButtonsInnerLightShadow()
        }
        //Button's outer light shadow (top left)
        .shadow(color: lightShadow.opacity(opacity), radius: shadowRadiusXY, x: -shadowRadiusXY, y: -shadowRadiusXY)
        //Button's outer dark shadow (bottom right)
        .shadow(color: darkShadow.opacity(opacity), radius: shadowRadiusXY, x: shadowRadiusXY, y: shadowRadiusXY)
    }
    
    func ShapeAndColor() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(mainColor)
    }
    
    func ButtonsDardEdge() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(darkShadow.opacity(opacityOp), lineWidth: 2)
            .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors:[darkShadow.opacity(opacityOp), Color.clear], startPoint: .top, endPoint: .bottom)))
    }
    
    func ButtonsInnerDarkShadow() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(lThemeDarkShadow, lineWidth: 2)
            .blur(radius: 3)
            .offset(x: 1, y: 1)
            .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors: [darkShadow.opacity(opacityOp), Color.clear], startPoint: .top, endPoint: .bottom)))
    }
    
    func ButtonsInnerLightShadow() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(lightShadow.opacity(opacityOp), lineWidth: 2)
            .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors: [Color.clear, lightShadow.opacity(opacityOp)], startPoint: .top, endPoint: .bottom)))
    }
}

struct NeumorphicButtonStyle: ButtonStyle {
    @State var  opacity : CGFloat = 1
    @State var  opacityOp : CGFloat = 0
    @State var  shadowRadiusXY : CGFloat = 3
    @State var  scale : CGFloat = 1
    let width : CGFloat
    let cornerRadius : CGFloat
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: width)
            .foregroundColor(.primary)
            .background(NeuButtonBackgroundView(cornerRadius: cornerRadius, opacity: opacity, opacityOp: opacityOp, shadowRadiusXY: shadowRadiusXY))
            .scaleEffect(scale)
            .onChange(of: configuration.isPressed) { newValue in
                if (!configuration.isPressed) {
                    withAnimation(.spring(dampingFraction: 0.5).speed(2)) {
                        opacity = 0
                        opacityOp = 1
                        scale = 0.95
                        shadowRadiusXY = 0
                    }
                } else {
                    withAnimation(.spring(dampingFraction: 0.5).speed(2)) {
                        opacity = 1
                        opacityOp = 0
                        scale = 1
                        shadowRadiusXY = 3
                    }
                }
            }
    }
}

struct CustomButton : View {
    var body: some View {
        ZStack {
            Button("Click") {
                
            }
            .buttonStyle(NeumorphicButtonStyle(width: 200, cornerRadius : 20))
        }
    }
}
