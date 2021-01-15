//
//  FloatingTextField.swift
//  Work Cycle
//
//  Created by amanshu raikwar on 14/01/21.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    let text: Binding<String>

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField(title, text: text)
                .foregroundColor(.blue)
                .keyboardType(.decimalPad)
        }
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTextField(
            title: "Title", text: .constant(""))
    }
}
