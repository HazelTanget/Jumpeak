//
//  CircleEmojiView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 16.04.2023.
//

import SwiftUI

struct CircleEmojiView: View {
    var emoji: String

    var body: some View {
        ZStack {
            Circle()
                .fill(Asset.Colors.inputColor.swiftUIColor)
            
            Text(emoji)
                .font(.system(size: 40))
        }
        .frame(width: 168, height: 168)
    }
}
