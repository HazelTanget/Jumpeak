//
//  ErrorView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 17.04.2023.
//

import SwiftUI

struct ErrorView: View {
    var emoji: String
    var title: String

    var body: some View {
        HStack (spacing: 0) {
            Text(emoji)
                .sFont()
                .padding(8)
                .background(Asset.Colors.inputColor.swiftUIColor)
                .cornerRadius(50)
            
            Text(title)
                .sFont()
                .foregroundColor(Asset.Colors.errorColor.swiftUIColor)
                .padding(8)
                .background(Asset.Colors.inputColor.swiftUIColor)
                .cornerRadius(50)
            
        }
    }
}
