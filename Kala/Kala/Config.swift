//
//  Config.swift
//  Kala
//
//  Created by Andrew Kuzmich on 21.01.2023.
//

import Foundation
import SwiftUI

class Config {
    static let shared = Config()
    
    private init() { }
    
    @AppStorage("Save_StopSettings") var saveStopSettings: ActionTimerStopped = .AskAction
    @AppStorage("Save_PlaySettings") var saveIsGoingSettings: ActionTimerGoing = .AskAction
}
