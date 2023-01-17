//
//  PropertiesViewModel.swift
//  Kala
//
//  Created by Andrew Kuzmich on 10.01.2023.
//

import Foundation

struct DropDownMenuOptions : Identifiable, Hashable {
    let id = UUID().uuidString
    let option : String   
}
extension DropDownMenuOptions {
    static let saveSattings: DropDownMenuOptions = DropDownMenuOptions(option: "Не сохранять")
    static let allSavesSettings: [DropDownMenuOptions] = [
    DropDownMenuOptions(option: "Всегда сохранять результат"),
    DropDownMenuOptions(option: "Не сохранять"),
    DropDownMenuOptions(option: "")]
}
