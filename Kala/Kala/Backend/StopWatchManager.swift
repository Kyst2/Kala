//
//  StopWatchManager.swift
//  Temp
//
//  Created by Andrew Kuzmich on 24.12.2022.
//

import Foundation
import SwiftUI

class StopWatchManager: ObservableObject {
    enum stopWatchMode {
        case runned
        case stopped
        case paused
    }
    
    @Published var mode: stopWatchMode = .stopped
    
    @Published var secondsElapsed = 0.0
    var timer = Timer()
    
    func start() {
        mode = .runned
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            self.secondsElapsed += 0.1
        })
    }
    func pause() {
        timer.invalidate()
        mode = .paused
    }
    func stop() {
        timer.invalidate()
        secondsElapsed = 0
        mode = .stopped
    }
}
