//
//  WorkCycleTimer.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 11/01/21.
//

import Foundation

class WorkCycleTimer: ObservableObject {
    
    @Published var state: State
    var secondsElapsed: Int
    
    private let onUpdate: (Int) -> Void
    private var timer: Timer?
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var startDate: Date?
    
    init(onUpdate: @escaping (Int) -> Void) {
        self.onUpdate = onUpdate
        state = .idle
        secondsElapsed = 0
    }
    
    func start() {
        if (timer == nil) {
            startDate = Date()
            timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
                if let self = self, let startDate = self.startDate {
                    let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
                    self.update(secondsElapsed: Int(secondsElapsed))
                }
            }
        }
        state = .running
    }
    
    private func update(secondsElapsed: Int) {
        self.secondsElapsed = secondsElapsed
        onUpdate(secondsElapsed)
    }
    
    func stop() {
        timer?.invalidate()
        startDate = nil
        timer = nil
        state = .paused
    }
    
    func reset() {
        timer?.invalidate()
        startDate = nil
        timer = nil
        state = .idle
        secondsElapsed = 0
    }
    
    enum State {
        case idle, running, paused
    }
}
