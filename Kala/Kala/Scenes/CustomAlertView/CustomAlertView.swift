//
//  SwiftUIView.swift
//  Kala
//
//  Created by Andrew Kuzmich on 28.01.2023.
//

import SwiftUI

struct CustomAlertView: View {
    var body: some View {
        VStack(spacing: 20){
            
            VStack {
                Text("Предупреждение!")
                    .font(.system(size: 15,design: .monospaced))
                    .foregroundColor(.gray)
                
                Text("Вы уверены, что хотите закрыть приложение? ")
                    .foregroundColor(.gray)
                    .font(.system(size: 13,design: .monospaced))
                    .padding(.horizontal,6)
                    .padding(.vertical,5)
            }
            
            Button(action: { appCloseWithSave() }, label: {
                Text("Закрыть с сохранением")
                    .foregroundColor(.gray)
                    .font(.system(size: 13,design: .monospaced))
                    .frame(width: 200, height: 15)
            }).buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))
            
            Button(action: { appCloseAndDoNotSave() }, label: {
                Text("Не сохранять")
                    .foregroundColor(.gray)
                    .font(.system(size: 13,design: .monospaced))
                    .frame(width: 200, height: 15)
            }).buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))
            
            Button(action: { closeAlert() }, label: {
                Text("Отмена")
                    .foregroundColor(.gray)
                    .font(.system(size: 13,design: .monospaced))
                    .frame(width: 200, height: 15)
            }).buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))
        }
        .padding(30)
        .fixedSize()
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
fileprivate func closeAlert() {
    AppDelegate.instance.alertWindowController?.window?.close()
}

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
