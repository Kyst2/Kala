//
//  ButtonStyle.swift
//  Kala
//
//  Created by Andrew Kuzmich on 09.01.2023.
//
import SwiftUI
import Foundation

//struct Colors {
//    public static let mainColor = "mainColor"
//    public static let lightShadow = "lightShadow"
//    public static let darkShadow = "darkShadow"
//}
//
//
//struct NeuButtonBackgroundView : View  {
//    let cornerRadius : CGFloat
//    @Binding var  opacity : CGFloat
//    @Binding var  opacityOp : CGFloat
//    @Binding var  shadowRadiusXY : CGFloat
//    
//    var body: some View {
//        ZStack {
//            //Button shape and color
//            RoundedRectangle(cornerRadius: cornerRadius)
//                .fill(Color(Colors.mainColor))
//            //Button's dark edge (top left)
//            RoundedRectangle(cornerRadius: cornerRadius)
//                .stroke(Color(Colors.darkShadow).opacity(opacityOp), lineWidth: 2)
//                .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors:[Color(Colors.darkShadow).opacity(opacityOp), Color.clear], startPoint: .top, endPoint: .bottom)))
//            //Button's inner dark shadow (top left)
//            RoundedRectangle(cornerRadius: cornerRadius)
//                .stroke(Color(Colors.darkShadow), lineWidth: 2)
//                .blur(radius: 3)
//                .offset(x: 1, y: 1)
//                .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors: [Color(Colors.darkShadow).opacity(opacityOp), Color.clear], startPoint: .top, endPoint: .bottom)))
//            //Button's inner light edge (bottom right)
//            RoundedRectangle(cornerRadius: cornerRadius)
//                .stroke(Color(Colors.lightShadow).opacity(opacityOp), lineWidth: 2)
//                .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors: [Color.clear, Color(Colors.lightShadow).opacity(opacityOp)], startPoint: .top, endPoint: .bottom)))
//        }
//        //Button's outer light shadow (top left)
//        .shadow(color: Color(Colors.lightShadow).opacity(opacity), radius: shadowRadiusXY, x: -shadowRadiusXY, y: -shadowRadiusXY)
//        //Button's outer dark shadow (bottom right)
//        .shadow(color: Color(Colors.darkShadow).opacity(opacity), radius: shadowRadiusXY, x: shadowRadiusXY, y: shadowRadiusXY)
//    }
//    
//}
//
//struct NeumorphicButtonStyle: ButtonStyle {
//    @State var  opacity : CGFloat = 1
//    @State var  opacityOp : CGFloat = 0
//    @State var  shadowRadiusXY : CGFloat = 3
//    @State var  scale : CGFloat = 1
//    let width : CGFloat
//    let cornerRadius : CGFloat
//    
//    func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .padding()
//            .frame(width: width)
//            .foregroundColor(.primary)
//            .background(NeuButtonBackgroundView(cornerRadius: cornerRadius, opacity: $opacity, opacityOp: $opacityOp, shadowRadiusXY: $shadowRadiusXY))
//            .scaleEffect(scale)
//            .onChange(of: configuration.isPressed) { newValue in
//                if (!configuration.isPressed) {
//                    withAnimation(.spring(dampingFraction: 0.5).speed(2)) {
//                        opacity = 0
//                        scale = 0.95
//                        opacityOp = 1
//                        shadowRadiusXY = 0
//                    }
//                } else {
//                    withAnimation(.spring(dampingFraction: 0.5).speed(2)) {
//                        opacity = 1
//                        scale = 1
//                        opacityOp = 0
//                        shadowRadiusXY = 3
//                    }
//                }
//            }
//    }
//}
