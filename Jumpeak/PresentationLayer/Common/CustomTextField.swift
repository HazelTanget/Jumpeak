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
    var isDateField = false
    @Binding var date: Date
    @Binding var fieldState: TextFieldState
    @Binding var text: String
    @FocusState private var isActive: Bool
    @State private var showPassword = false
    
    init(placeholder: String, fieldState: Binding<TextFieldState> = .constant(.na), isDateField: Bool = false, text: Binding<String> = .constant(""), isSecure: Bool = false,
         date: Binding<Date> = .constant(Date())) {
        self.isSecure = isSecure
        self.placeholder = placeholder
        self.isDateField = isDateField
        _fieldState = fieldState
        _text = text
        _date = date
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            ZStack(alignment: .leading) {
                VStack {
                    if isSecure {
                        if showPassword {
                            TextField(placeholder, text: $text) { self.isActive = $0 }
                                .mFont()
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                                .focused($isActive)
                        } else  {
                            SecureField(placeholder, text: $text)
                                .mFont()
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                                .focused($isActive)
                        }
                    } else {
                        HStack {
                            TextField(placeholder, text: $text)
                                .mFont()
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                                .focused($isActive)
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
                    
                    if(isDateField) {
                        DatePicker("", selection: $date, displayedComponents: [.date])
                            .blendMode(.destinationOver)
                    }
                }
                .overlay {
                    switch self.fieldState {
                    case .error:
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 2)
                            .fill(Asset.Colors.errorColor.swiftUIColor)
                    case .na:
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 2)
                            .fill(isActive ? Asset.Colors.accentColor.swiftUIColor : .clear)
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


enum TextFieldState {
    case error
    case na
}
