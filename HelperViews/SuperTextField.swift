//
//  SuperTextField.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 12/15/22.
//

import SwiftUI

struct SuperTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: ()->() = {}
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}

struct SuperTextField_Previews: PreviewProvider {
    static var previews: some View {
        SuperTextField(placeholder: Text(verbatim: "Textt"), text: .constant("Text"))
    }
}
