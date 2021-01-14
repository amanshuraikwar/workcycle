//
//  WorkCycle.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 11/01/21.
//

import Foundation

class WorkCycle: ObservableObject {
    let workMinutes: Int
    let restMinutes: Int
    
    @Published var phase: Phase
    @Published var phaseSecondsRemaining: Int
    @Published var phaseProgress: Double
    @Published var timerState: WorkCycleTimer.State
    
    private var workCycleTimer: WorkCycleTimer? = nil
    
    init(workMinutes: Int, restMinutes: Int) {
        self.workMinutes = workMinutes
        self.restMinutes = restMinutes
        phase = .work
        phaseSecondsRemaining = workMinutes * 60
        phaseProgress = 0.0
        timerState = WorkCycleTimer.State.idle
    }
    
    private func updatePhaseProgress() {
        if phase == .work {
            phaseProgress = Double(workMinutes * 60 - phaseSecondsRemaining) / Double(workMinutes * 60)
        } else if phase == .rest {
            phaseProgress = Double(restMinutes * 60 - phaseSecondsRemaining) / Double(restMinutes * 60)
        } else {
            phaseProgress = 0.0
        }
    }
    
    func start() {
        workCycleTimer?.reset()
        workCycleTimer = WorkCycleTimer(onUpdate: { secondsElapsed -> Void in
            self.phaseSecondsRemaining = self.workMinutes * 60 - secondsElapsed
        })
        workCycleTimer?.start()
        timerState = workCycleTimer?.state ?? .idle
    }
    
    func reset() {
        workCycleTimer?.reset()
        workCycleTimer = nil
        timerState = .idle
        phase = .work
        phaseSecondsRemaining = workMinutes * 60
    }
    
    enum Phase {
        case work, rest
    }
}
