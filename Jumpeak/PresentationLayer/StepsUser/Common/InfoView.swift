//
//  InfoView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 24.04.2023.
//

import SwiftUI

struct InfoView: View {
    var title: String
    var firstText: String
    var secondText: String

    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text(title)
                    .foregroundColor(Asset.Colors.thirdFontColor.swiftUIColor)
                    .xlFont(weight: .semibold)
                
                Text(firstText)
                    .foregroundColor(Asset.Colors.thirdFontColor.swiftUIColor.opacity(0.65))
                    .lFont()
                    .padding(.top, 16)
                
                Text(secondText)
                    .foregroundColor(Asset.Colors.thirdFontColor.swiftUIColor.opacity(0.65))
                    .lFont()
                    .padding(.top, 16)
                
                Spacer()
                
                HStack {
                    AccentButton(text: Strings.enter,
                                 foregroundColor: Asset.Colors.mainFontColor.swiftUIColor,
                                 backgroundColor: Asset.Colors.background.swiftUIColor) {
                        }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 52)
            }
            .padding(.top, 102)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .background(Asset.Colors.additionalBackground.swiftUIColor)
        }
    }
}
