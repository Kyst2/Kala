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
                ButtonAlertView("Save current session value") {
                    saveAndClose()
                }
                ButtonAlertView("Reset value to 00.00.00") {
                    close()
                }
                if MainViewModel.shared.st.isGoing == true {
                    ButtonAlertView("Timer going even if Kala closed") {
                        timeGoingOnKalaClose()
                    }
                }
                ButtonAlertView("Сancel") {
                    cancel()
                }
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

struct ButtonAlertView: View {
    
    @Environment(\.colorScheme) var theme
    var themeIsDark: Bool { theme == .dark}
    
    let action: () -> ()
    let text: LocalizedStringKey
    
    init (_ text: LocalizedStringKey, action: @escaping () -> ()) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: { action() } ) {
            Text(text)
                .foregroundColor(themeIsDark ? .gray : .darkGray)
                .font(.system(size: 13,design: .monospaced))
                .fixedSize()
        }
        .buttonStyle(NeumorphicButtonStyle(width: 300, height: 25, cornerRadius : 20))
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
    Config.shared.timePassedInterval.value = 0
    Config.shared.appDisableTimeStamp.value = 0
    NSApplication.shared.terminate(nil)
}

fileprivate func saveAndClose() {
    Config.shared.timePassedInterval.value = MainViewModel.shared.st.diff
    Config.shared.appDisableTimeStamp.value = 0
    NSApplication.shared.terminate(nil)
}

fileprivate func timeGoingOnKalaClose() {
    Config.shared.appDisableTimeStamp.value = CACurrentMediaTime()
    Config.shared.timePassedInterval.value = MainViewModel.shared.st.diff
    NSApplication.shared.terminate(nil)
}
