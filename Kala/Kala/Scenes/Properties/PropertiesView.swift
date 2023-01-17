//
//  PropertiesView.swift
//  Kala
//
//  Created by Andrew Kuzmich on 17.01.2023.
//

import SwiftUI

struct PropertiesView: View {
    @State private var saveOption: DropDownMenuOptions? = nil
    
    var body: some View {
        VStack{
            DropDownMenu(
                selectedOption: self.$saveOption,
                placeholder: "Выбири настройки сохранения ",
                options: DropDownMenuOptions.allSavesSettings
            )
        }
        Spacer()
    }
}

struct PropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesView()
    }
}
