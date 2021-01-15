//
//  ContentView.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 03/01/21.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var workCycle = WorkCycle(workMinutes: 1, restMinutes: 1)
    @State private var settingsOpened = false
    @State private var workCycleData = WorkCycle.Data()
    @State private var notificationGranted = true
    
    var body: some View {
        
        ZStack {
                        
            VStack {
            
                HeaderView(notificationGranted: $notificationGranted, settingsOpened: $settingsOpened)
                
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
                
                ActionButton(timeState: $workCycle.timerState, onStart: {
                    workCycle.start()
                }, onStop: {
                    workCycle.reset()
                })
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
            checkNotificationPermission()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive && workCycle.timerState == .running {
                enqueueNotification()
            }
        }
    }
    
    func checkNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            notificationGranted = granted
        }
    }
    
    func enqueueNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Phase complete"
        content.subtitle = "Phase complete bebe \(workCycle.phaseSecondsRemaining)"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(workCycle.phaseSecondsRemaining), repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
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
