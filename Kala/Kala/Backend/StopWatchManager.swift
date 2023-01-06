import Foundation
import SwiftUI
import QuartzCore


class StopWatchManager: ObservableObject {

    enum stopWatchMode {
        case runned
        case stopped
        case paused
    }

    @Published var mode: stopWatchMode = .stopped
    @AppStorage("SAVE_seconds") var secondsElapsed = 0.0
    @AppStorage("SAVE_MINUTES") var minutes = 0

    @AppStorage("SAVE_HOURS") var hours = 0
    @AppStorage("SAVE_DAYS") var days = 0

    var timer = Timer()
    func start() {
        mode = .runned
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            self.secondsElapsed += 1.1
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

