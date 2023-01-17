//
//  DropDawnMenuList.swift
//  Kala
//
//  Created by Andrew Kuzmich on 17.01.2023.
//

import SwiftUI

struct DropDawnMenuList: View {
    let options: [DropDownMenuOptions]
    
    let oneSelectedAction: (_ optional: DropDownMenuOptions) -> Void
    var body: some View {
        ScrollView{
            LazyVStack(alignment: .leading, spacing: 2){
                ForEach(options) { options in
                    DropDownMenuListRow(option: options, oneSelectedAction: self.oneSelectedAction)
                }
            }
        }
        .frame(height: 200)
        .padding(.vertical,5)
        .overlay{
                RoundedRectangle(cornerRadius: 5)
                .stroke(.gray , lineWidth: 2)
        }
    }
}

struct DropDawnMenuList_Previews: PreviewProvider {
    static var previews: some View {
        DropDawnMenuList(options: DropDownMenuOptions.allSavesSettings, oneSelectedAction: {_ in })
    }
}
