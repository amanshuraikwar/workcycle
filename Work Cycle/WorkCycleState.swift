//
//  WorkCycleState.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 15/01/21.
//

import Foundation

struct WorkCycleState : Codable {
    var createTimeStamp: Date = Date()
    var phaseCompletionTimeStamp: Date
}

extension WorkCycle {
    func state() -> WorkCycleState {
        return WorkCycleState(phaseCompletionTimeStamp: Date() + TimeInterval(self.phaseSecondsRemaining))
    }
}
