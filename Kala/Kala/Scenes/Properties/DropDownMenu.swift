//
//  PropertiesView.swift
//  Kala
//
//  Created by Andrew Kuzmich on 10.01.2023.
//

import Foundation
import SwiftUI

struct DropDownMenu: View {
    @State private var isOptionalPresent: Bool = false
    
    @Binding var selectedOption: DropDownMenuOptions?
    let placeholder: String
    let options: [DropDownMenuOptions]
    var body: some View {
        Button {
            withAnimation {
                self.isOptionalPresent.toggle()
            }
        } label: {
            HStack{
                Text(selectedOption == nil ? placeholder : selectedOption!.option)
                    .fontWeight(.medium)
                    .foregroundColor(selectedOption == nil ? .gray : .black)
                
                Spacer()
                
                Image(systemName: self.isOptionalPresent ? "chevron.up" : "chevron.down")
                    .foregroundColor(.black)
            }
        }
        .padding()
//        .overlay{
//            RoundedRectangle(cornerRadius: 5)
//                .stroke(.gray,lineWidth: 2)
//        }
        .overlay(alignment: .top){
            VStack{
                if self.isOptionalPresent {
                    Spacer(minLength: 60)
                    DropDawnMenuList(options: self.options) { option in
                        self.isOptionalPresent = false
                        self.selectedOption = option
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
struct DropDownMenu_Previews : PreviewProvider {
    static var previews: some View{
        DropDownMenu(
            selectedOption: .constant(nil),
            placeholder: "Выберите настройки сохранения",
            options: DropDownMenuOptions.allSavesSettings)
        
    }
}
