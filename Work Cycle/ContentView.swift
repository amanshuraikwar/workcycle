//
//  ContentView.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 03/01/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var workCycle = WorkCycle(workMinutes: 52, restMinutes: 17)
    @State private var settingsOpened = false
    @State private var workCycleData = WorkCycle.Data()
    
    var body: some View {
        
        ZStack {
            
            VStack {
            
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        settingsOpened = true
                    }) {
                        Text(.init(systemName: "gearshape.fill"))
                            .padding()
                    }
                    
                }
                
                Spacer()
            }
            
            VStack {
                
                Spacer()
                
                CountDownView(phaseSecondsRemaining: $workCycle.phaseSecondsRemaining, phase: $workCycle.phase)
                
                if workCycle.timerState == .running {
                    Text(workCycle.phase.phaseText)
                }

                Spacer()
            }
            
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
        .sheet(isPresented: $settingsOpened) {
            NavigationView {
                SettingsView(workCycleData: $workCycleData)
                    .navigationBarItems(trailing: Button("Done") {
                        settingsOpened = false
                    })
                    .navigationBarTitle("Settings")
            }
        }
        .onAppear {
            workCycleData = workCycle.data
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

extension WorkCycle.Phase {
    var phaseText: String {
        if self == .rest {
            return "Ponder infinity"
        } else {
            return "Keep working"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
