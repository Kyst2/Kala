//
//  DropDownMenuListRow.swift
//  Kala
//
//  Created by Andrew Kuzmich on 17.01.2023.
//

import SwiftUI

struct DropDownMenuListRow: View {
    let option: DropDownMenuOptions
    
    let oneSelectedAction: (_ optional: DropDownMenuOptions) -> Void
    var body: some View {
        Button {
            self.oneSelectedAction(option)
        } label: {
            Text(option.option)
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        .foregroundColor(.black)
            .padding(.vertical,5)
            .padding(.horizontal,5)
    }
}

struct DropDownMenuListRow_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenuListRow(option: DropDownMenuOptions.saveSattings, oneSelectedAction: {_ in })
    }
}
