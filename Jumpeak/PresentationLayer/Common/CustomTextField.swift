//
//  CustomTextField.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    var isSecure: Bool = true
    @Binding var text: String
    @State private var isActive = false
    @State private var showPassword = false
    
    init(placeholder: String, text: Binding<String>, isSecure: Bool = false) {
        self.isSecure = isSecure
        self.placeholder = placeholder
        _text = text
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            ZStack(alignment: .leading) {
                VStack {
                    if isSecure {
                        if showPassword {
                            TextField(placeholder, text: $text) { self.isActive = $0 }
                                .mFont()
                        } else  {
                            SecureField(placeholder, text: $text)
                                .mFont()
                        }
                    } else {
                        HStack {
                            TextField(placeholder, text: $text) { self.isActive = $0 }
                                .mFont()
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                .background(Asset.Colors.inputColor.swiftUIColor)
                .cornerRadius(8)
                .textFieldStyle(.plain)
                .overlay(alignment: .trailing) {
                    if isSecure {
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                            .padding(.trailing, 24)
                            .onTapGesture {
                                showPassword.toggle()
                            }
                    }
                }
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(placeholder: "fdsf", text: .constant(""), isSecure: true)
    }
}
