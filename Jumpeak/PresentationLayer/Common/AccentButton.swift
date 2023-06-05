//
//  AccentButton.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import SwiftUI

struct AccentButton: View {

    var text: String
    var foregroundColor: Color
    var backgroundColor: Color
    @Binding var isEnable: Bool
    var action: () -> ()

    init(text: String, foregroundColor: Color = Asset.Colors.thirdFontColor.swiftUIColor, backgroundColor: Color = Asset.Colors.accentColor.swiftUIColor, isEnable: Binding<Bool> = .constant(true), action: @escaping () -> Void) {
        self.text = text
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        _isEnable = isEnable
        self.action = action
    }
    
    var body: some View {
        Button {
            guard isEnable else { return }
            action()
        } label: {
            Text(text)
                .mFont(weight: .semibold)
                .foregroundColor(foregroundColor)
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity)
        }
        .background(isEnable ? backgroundColor : backgroundColor.opacity(0.7))
        .cornerRadius(8)
        .disabled(!isEnable)
        
    }
}

struct AccentButton_Previews: PreviewProvider {
    static var previews: some View {
        AccentButton(text: Strings.enter, backgroundColor: Asset.Colors.accentColor.swiftUIColor) {
            
        }
    }
}
