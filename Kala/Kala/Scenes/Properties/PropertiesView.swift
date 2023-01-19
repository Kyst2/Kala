//
//  PropertiesView.swift
//  Kala
//
//  Created by Andrew Kuzmich on 17.01.2023.
//

import SwiftUI

struct PropertiesView: View {
    @State private var saveStopOption: DropDownMenuOptions? = nil
    @State private var savePlayOption: DropDownMenuOptions? = nil
    var body: some View {
        ScrollView{
            VStack{
                DropDownMenu(
                    selectedOption: self.$saveStopOption,
                    placeholder: "Действие при закрытие если таймер на паузе",
                    options: DropDownMenuOptions.stopTimerSettings
                )
                DropDownMenu(
                    selectedOption: self.$savePlayOption,
                    placeholder: "Действие при закрытие если таймер идет",
                    options: DropDownMenuOptions.playTimerSettings
                )
            }
            Spacer()
        }
    }
}

struct PropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesView()
    }
}
