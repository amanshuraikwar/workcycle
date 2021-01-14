//
//  ContentView.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 03/01/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var workCycle = WorkCycle(workMinutes: 52, restMinutes: 17)
    
    var body: some View {
        
        ZStack {
            
            
            CountDownView(phaseSecondsRemaining: $workCycle.phaseSecondsRemaining, phase: $workCycle.phase)
            
            VStack {
                
                Spacer()
                
                if workCycle.timerState == .idle {
                    
                    Button(action: {
                        workCycle.start()
                    }) {
                    
                        Text(.init(systemName: "play.fill"))
                            .font(.largeTitle)
                            .padding()
                            .background(
                                Circle()
                                    .fill(Color.blue)
                                    .scaledToFill()
                            )
                            .foregroundColor(Color.white)
                    }
                    .padding(.bottom)
                    
                } else if workCycle.timerState == .running {
                    
                    Button(action: {
                        workCycle.reset()
                    }) {
                    
                        Text(.init(systemName: "stop.fill"))
                            .font(.largeTitle)
                            .padding()
                            .background(
                                Circle()
                                    .fill(Color.blue)
                                    .scaledToFill()
                            )
                            .foregroundColor(Color.white)
                    }
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle("Work Cycle Timer")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
