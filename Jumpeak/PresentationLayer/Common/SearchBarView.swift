//
//  SearchBarView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 25.04.2023.
//

import SwiftUI

struct SearchBarView: View {
    var title: String
    @Binding var text: String
    var body: some View {
        TextField(title, text: $text)
            .padding(.vertical, 20)
            .padding(.leading, 24)
            .background(Asset.Colors.inputColor.swiftUIColor)
            .cornerRadius(8)
            .overlay(alignment: .trailing) {
                Asset.Assets.searchIc.swiftUIImage
                    .iconModifier()
                    .padding(.trailing, 24)
            }
    }
}
