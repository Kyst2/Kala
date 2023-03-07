//
//  SwiftUIView.swift
//  Kala
//
//  Created by Andrew Kuzmich on 28.01.2023.
//

import SwiftUI

struct CustomAlertView: View {
    
    @Environment(\.colorScheme) var theme
    var themeIsDark: Bool { theme == .dark}
    
    var body: some View {
        ZStack{
            VisualEffectView(type:.behindWindow, material: themeIsDark ?  .m6_tooltip : .m1_hudWindow)
            
            DragWndView()
            
            VStack(spacing: 20){
                VStack {
                    Text("Warning!")
                        .font(.system(size: 15,design: .monospaced))
                        .foregroundColor(themeIsDark ? .gray : .darkGray)
                    
                    Text("Are you sure you want to close the application?")
                        .foregroundColor(themeIsDark ? .gray : .darkGray)
                        .font(.system(size: 13,design: .monospaced))
                        .padding(.horizontal,6)
                        .padding(.vertical,5)
                        .fixedSize()
                    
                }
                
                Button(action: { saveAndClose() }, label: {
                    Text("Save current session value")
                        .foregroundColor(themeIsDark ? .gray : .darkGray)
                        .font(.system(size: 13,design: .monospaced))
                }).buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))
                
                Button(action: { close() }, label: {
                    Text("Reset value to 00.00.00")
                        .foregroundColor(themeIsDark ? .gray : .darkGray)
                        .font(.system(size: 13,design: .monospaced))
                }).buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))
                
                if MainViewModel.shared.st.isGoing == true {
                    Button(action: { timeGoingOnKalaClose() }, label: {
                        Text("Timer going even if Kala closed")
                            .foregroundColor(themeIsDark ? .gray : .darkGray)
                            .font(.system(size: 13,design: .monospaced))
                    }).buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))
                }
                
                Button(action: { cancel() }, label: {
                    Text("Сancel")
                        .foregroundColor(themeIsDark ? .gray : .darkGray)
                        .font(.system(size: 13,design: .monospaced))
                }).buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))
            }
            
            .padding(30)
            .fixedSize()
            
        }.ignoresSafeArea()
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
fileprivate func cancel() {
    AppDelegate.instance.alertWindowController?.window?.close()
    AppDelegate.instance.alertWindowController = nil
}

fileprivate func close() {
    MainViewModel.shared.config.timePassedInterval = 0
    MainViewModel.shared.config.appDisableTimeStamp = nil
    NSApplication.shared.terminate(nil)
}

fileprivate func saveAndClose() {
    MainViewModel.shared.config.timePassedInterval = MainViewModel.shared.st.diff
    MainViewModel.shared.config.appDisableTimeStamp = nil
    NSApplication.shared.terminate(nil)
}

fileprivate func timeGoingOnKalaClose() {
    MainViewModel.shared.config.appDisableTimeStamp = CACurrentMediaTime()
    MainViewModel.shared.config.timePassedInterval = MainViewModel.shared.st.diff
    NSApplication.shared.terminate(nil)
}
