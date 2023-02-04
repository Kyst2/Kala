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
                .padding(.vertical,5)
                .fixedSize()
            Spacer()
            Button(action: {
                MainViewModel.shared.pause()
                NSApplication.shared.terminate(self)
            }, label: {
                Text("Закрыть с сохранением")
                    .foregroundColor(.gray)
                    .font(.system(size: 13,design: .monospaced))
                    .frame(width: 200, height: 15)
            })
            //.buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 20)))
            
            Spacer()
            Button(action: {
                NSApplication.shared.terminate(self)
                
            }, label: {
                Text("Нет")
                    .foregroundColor(.gray)
                    .font(.system(size: 13,design: .monospaced))
                    .frame(width: 200, height: 15)
            })
            //.buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 20)))
            Spacer()
            Button(action: {
                MainViewModel.shared.pause()
                MainViewModel.shared.config.timePassedInterval = CFTimeInterval(0)
                NSApplication.shared.terminate(self)
            }, label: {
                Text("Не сохранять")
                    .foregroundColor(.gray)
                    .font(.system(size: 13,design: .monospaced))
                    .frame(width: 200, height: 15)
            })
            //.buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 20)))
            
            Spacer()
        }.frame(width: 350, height: 300)
            .background(Color.offWhite)
        //            .cornerRadius(12)
            .clipped()
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView()
    }
}

