import Foundation

struct Throttler {
    var throttleIntervalInSeconds = 0.5
    private var lastCallTime: TimeInterval = Date().timeIntervalSince1970
    
    private var now: TimeInterval {
        return Date().timeIntervalSince1970
    }
    
    mutating func onAction(_ action: @escaping () -> Void) {
        let timePassed = now - lastCallTime
        if timePassed >= throttleIntervalInSeconds {
            action()
            self.lastCallTime = now
        }
    }
}
