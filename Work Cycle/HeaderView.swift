//
//  HeaderView.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 16/01/21.
//

import SwiftUI

struct HeaderView: View {
    @Binding var notificationGranted: Bool
    @Binding var settingsOpened: Bool
    
    var body: some View {
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
            
            if !notificationGranted {
                NotificationPermissionView()
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(notificationGranted: .constant(false), settingsOpened: .constant(false))
    }
}
