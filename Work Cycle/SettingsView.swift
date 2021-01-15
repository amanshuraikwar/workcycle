//
//  SettingsView.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 14/01/21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var workCycleData: WorkCycle.Data
    
    var body: some View {
        List {
            Section {
                FloatingTextField(title: "Work Minutes", text: $workCycleData.workMinutes)
                FloatingTextField(title: "Rest Minutes", text: $workCycleData.restMinutes)
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(workCycleData: .constant(WorkCycle(workMinutes: 52, restMinutes: 17).data))
    }
}
