//
//  PropertiesView.swift
//  Kala
//
//  Created by Andrew Kuzmich on 10.01.2023.
//

import Foundation
import SwiftUI

struct DropDownMenu: View {
    @State var isOptionalPresent: Bool = false
    
    @Binding var selectedOption: DropDownMenuOptions?
    let placeholder: String
    let options: [DropDownMenuOptions]
    var body: some View {
        VStack(spacing: 1){
        Button {
            withAnimation {
                self.isOptionalPresent.toggle()
            }
        } label: {
            HStack{
                Text(selectedOption == nil ? placeholder : selectedOption!.option)
                    .fontWeight(.medium)
                    .foregroundColor(selectedOption == nil ? .gray : .black)
                    .padding(.vertical )
                
                Spacer()
                
                Image(systemName: self.isOptionalPresent ? "chevron.up" : "chevron.down")
                    .foregroundColor(.black)
            }
        }
        .padding(.vertical ,10)
//        .overlay{
//            RoundedRectangle(cornerRadius: 5)
//                .stroke(.gray,lineWidth: 2)
//        }
//        .overlay(alignment: .top){
            VStack{
                if self.isOptionalPresent {
//                    Spacer(minLength: 2)
                    DropDawnMenuList(options: self.options) { option in
                        self.isOptionalPresent = false
                        self.selectedOption = option
                    }
                }
            }
//        }.padding()
        .padding(.horizontal)
    }
    }
}
struct DropDownMenu_Previews : PreviewProvider {
    static var previews: some View{
        DropDownMenu(
            selectedOption: .constant(nil),
            placeholder: "Действие при закрытие если таймер на паузе",
            options: DropDownMenuOptions.stopTimerSettings)
        
    }
}
