//
//  TimerView.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 03/01/21.
//

import SwiftUI

struct CountDownView: View {
    @Binding var phaseSecondsRemaining: Int
    @Binding var phase: WorkCycle.Phase
    
    var body: some View {
        Text(phaseSecondsRemaining.timeString)
            .font(.system(.largeTitle, design: .monospaced))
            .bold()
            .foregroundColor(phase.textColor)
            .padding()
    }
}

extension WorkCycle.Phase {
    var textColor: Color {
        if self == .rest {
            return .blue
        } else {
            return .black
        }
    }
}

extension Int {
    var timeString: String { String(format: "%02d:%02d", arguments: [self/60, self%60]) }
}

struct CountDownView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView(phaseSecondsRemaining: .constant(490), phase: .constant(.rest))
    }
}
