//
//  FirstStepRegistration.swift
//  Jumpeak
//
//  Created by Денис Большачков on 16.04.2023.
//

import SwiftUI

struct RegistrationStepView<T: View>: View {
    
    var emojiSymb: String
    var descriptionTitle: String
    @Binding var selection: Int
    var stepContent: T
    var action: () -> ()
    

    init(emojiSymb: String, descriptionTitle: String, selection: Binding<Int>, @ViewBuilder stepContent: () -> T, action: @escaping () -> ()) {
        self.emojiSymb = emojiSymb
        self.descriptionTitle = descriptionTitle
        self._selection = selection
        self.stepContent = stepContent()
        self.action = action
    }

    var body: some View {
        VStack {
            CircleEmojiView(emoji: emojiSymb)
                .padding(.top, 40)

            HStack (spacing: 3) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(index == selection ? Asset.Colors.dotsColor.swiftUIColor : Asset.Colors.dotsColor.swiftUIColor.opacity(0.5))
                        .frame(width: 4, height: 4)
                }
            }
            
            Text(descriptionTitle)
                .lFont(weight: .medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor.opacity(0.5))
                .padding(.top, 8)

            stepContent
            
            Spacer()

            AccentButton(text: Strings.next) {
                withAnimation {
                    action()
                }
            }
            .padding(.bottom, 52)
        }
        .padding(.horizontal, 16)
    }
}
