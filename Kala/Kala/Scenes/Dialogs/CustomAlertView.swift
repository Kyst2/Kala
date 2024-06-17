import SwiftUI

struct CustomAlertView: View {
    @Environment(\.colorScheme) var theme
    
    var body: some View {
        ZStack{
            VisualEffectView(type:.behindWindow, material: theme.isDark ?  .m6_tooltip : .m1_hudWindow)
            
            DragWndView()
            
            AlertInterface()
            
        }.ignoresSafeArea()
    }
    
    func AlertInterface() -> some View {
        VStack(spacing: 20){
            ConfirmationText()
            
            ButtonAlertView("Save current session value") {
                saveAndClose()
            }
            
            ButtonAlertView("Reset value to 00.00.00") {
                close()
            }
            
            TimerGoingButton()
            
            ButtonAlertView("Сancel") {
                cancel()
            }
        }
        .padding(30)
        .fixedSize()
    }
    
    func ConfirmationText() -> some View{
        VStack {
            Text("Warning!")
                .font(.system(size: 15,design: .monospaced))
                .foregroundColor(theme.isDark ? .gray : .darkGray)
            
            Text("Are you sure you want to close the application?")
                .foregroundColor(theme.isDark ? .gray : .darkGray)
                .font(.system(size: 13,design: .monospaced))
                .padding(.horizontal,6)
                .padding(.vertical,5)
                .fixedSize()
        }
    }
    
    @ViewBuilder
    func TimerGoingButton() -> some View {
        if MainViewModel.shared.st.isGoing == true {
            ButtonAlertView("Timer going even if Kala closed") {
                timeGoingOnKalaClose()
            }
        }
    }
}

struct ButtonAlertView: View {
    @Environment(\.colorScheme) var theme
    
    let action: () -> ()
    let text: LocalizedStringKey
    
    init (_ text: LocalizedStringKey, action: @escaping () -> ()) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: { action() } ) {
            Text(text)
                .foregroundColor(theme.isDark ? .gray : .darkGray)
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
