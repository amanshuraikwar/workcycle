//
//  ActionButton.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 16/01/21.
//

import SwiftUI

struct ActionButton: View {
    @Binding var timeState: WorkCycleTimer.State
    let onStart: () -> Void
    let onStop: () -> Void
    
    var body: some View {
        if timeState == .idle {
            
            Button(action: {
                onStart()
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
            
        } else if timeState == .running {
            
            Button(action: {
                onStop()
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

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(timeState: .constant(.idle), onStart: {}, onStop: {})
    }
}
