//
//  SecureInputView.swift
//  porra f1
//
//  Created by Alejandro Miranda on 13/3/23.
//

import SwiftUI

struct SecureInputView: View {
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(LocalizedStringKey(title), text: $text)
                } else {
                    TextField(LocalizedStringKey(title), text: $text)
                }
            }

            if !self.text.isEmpty {
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .accentColor(self.isSecured ? .gray : Color("AccentColor"))
                }
            }
        }
    }
}

struct SecureInputView_Previews: PreviewProvider {
    static var previews: some View {
        SecureInputView("Test", text: .constant("Test"))
    }
}
