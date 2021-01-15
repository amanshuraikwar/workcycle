//
//  NotificationPermissionView.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 15/01/21.
//

import SwiftUI

struct NotificationPermissionView: View {
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundColor(.yellow)
            Text("Please give notification permissions in settings")
                .padding(.leading)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.gray)
    }
}

struct NotificationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermissionView()
    }
}
