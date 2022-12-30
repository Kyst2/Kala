//
//  ContentView.swift
//  Temp
//
//  Created by Andrew Kuzmich on 22.12.2022.
//

import SwiftUI

struct KalaMainView: View {
    
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    var body: some View {
        VStack{
            Text(String(format: "%.1f", stopWatchManager.secondsElapsed))
                .font(.custom("Avenir", size: 40))
                .padding(.top,150)
                .padding(.bottom,100)
                .padding(.trailing,200)
                .padding(.leading,200)
            if stopWatchManager.mode == .stopped {
                Button {self.stopWatchManager.start()} label: {
                    TimerButton(label: "Start", buttonColor: .orange, textColor: .black)
                }
                .buttonStyle(.plain)
                    
            }
            if stopWatchManager.mode == .runned {
                Button {self.stopWatchManager.pause()} label: {
                    TimerButton(label: "Pause", buttonColor: .orange, textColor: .black)
                }.buttonStyle(.plain)
                    .NeumorphicStyle()
            }
            if stopWatchManager.mode == .paused {
                Button {self.stopWatchManager.start()} label: {
                    TimerButton(label: "Start", buttonColor: .orange, textColor: .black)
                }.buttonStyle(.plain)
                    .NeumorphicStyle()
                Button {self.stopWatchManager.stop()} label: {
                    TimerButton(label: "Stop", buttonColor: .red, textColor: .white)
                }.buttonStyle(.plain)
                    .NeumorphicStyle()
                    .padding(.top, 10)
            }
            Spacer()
        }
        .background(VisualEffect())
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        KalaMainView()
    }
}

struct TimerButton: View {
    
    let label: String
    let buttonColor: Color
    let textColor: Color
    
    var body: some View {
        Text(label)
            .foregroundColor(textColor)
            .padding(.vertical,20)
            .padding(.horizontal,90)
            .background(buttonColor)
            .cornerRadius(15)
            
    }
}
