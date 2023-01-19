//
//  PropertiesViewModel.swift
//  Kala
//
//  Created by Andrew Kuzmich on 10.01.2023.
//
import SwiftUI
import Foundation

struct DropDownMenuOptions : Identifiable, Hashable {
    let id = UUID().uuidString
    let option : String
}
extension DropDownMenuOptions {
    static let saveSattings: DropDownMenuOptions = DropDownMenuOptions(option: "Не сохранять")
    static let stopTimerSettings: [DropDownMenuOptions] = [
        DropDownMenuOptions(option: "Закрыть с сохранением"),
        DropDownMenuOptions(option: "Новая сессия стартует с 00.00.0"),
        DropDownMenuOptions(option: "Запрашивать что выполнить")]
    static let playTimerSettings: [DropDownMenuOptions] = [
        DropDownMenuOptions(option: "Продолжить измерять время пока Kala закрыта"),
        DropDownMenuOptions(option: "Закрыть с сохранением времени"),
        DropDownMenuOptions(option: "Новая сессия стартует с 00.00.0"),
        DropDownMenuOptions(option: "Запрашивать что выполнить")
    ]
    
}
