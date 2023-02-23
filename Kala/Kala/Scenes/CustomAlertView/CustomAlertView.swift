//
//  SwiftUIView.swift
//  Kala
//
//  Created by Andrew Kuzmich on 28.01.2023.
//

import SwiftUI

struct CustomAlertView: View {
    var body: some View {
        VStack{
            Spacer()
            
            Text("Предупреждение!")
                .font(.system(size: 15,design: .monospaced))
                .foregroundColor(.gray)
            
            Text("Вы уверены, что хотите закрыть приложение? ")
                .foregroundColor(.gray)
                .font(.system(size: 13,design: .monospaced))
                .padding(.horizontal,6)
                .padding(.vertical,5)
            
            Spacer()
            
            Button(action: { appCloseWithSave() }, label: {
                Text("Закрыть с сохранением")
                    .foregroundColor(.gray)
                    .font(.system(size: 13,design: .monospaced))
                    .frame(width: 200, height: 15)
            }).buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))
            Spacer()
            
            Button(action: { appClose() }, label: {
                Text("Нет")
                    .foregroundColor(.gray)
                    .font(.system(size: 13,design: .monospaced))
                    .frame(width: 200, height: 15)
            }).buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))

            Spacer()
            
            Button(action: { appCloseAndDoNotSave() }, label: {
                Text("Не сохранять")
                    .foregroundColor(.gray)
                    .font(.system(size: 13,design: .monospaced))
                    .frame(width: 200, height: 15)
            }).buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))
            
            Spacer()
        }
        .frame(width: 350, height: 300)
        .backgroundGaussianBlur(type: .behindWindow, material: .m1_hudWindow)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView()
    }
}


///////////////////////
///HELERS
//////////////////////
fileprivate func appClose() {
    NSApplication.shared.terminate(nil)
}

fileprivate func appCloseAndDoNotSave() {
    MainViewModel.shared.pause()
    MainViewModel.shared.config.timePassedInterval = CFTimeInterval(0)
    NSApplication.shared.terminate(nil)
}

fileprivate func appCloseWithSave() {
    MainViewModel.shared.pause()
    NSApplication.shared.terminate(nil)
}
