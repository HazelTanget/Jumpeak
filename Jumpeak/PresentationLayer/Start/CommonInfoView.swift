//
//  StartView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import SwiftUI

struct CommonInfoView<T: View>: View {
    var text: String
    var content: T
    
    init(text: String, @ViewBuilder content: () -> T) {
        self.text = text
        self.content = content()
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text(getHelloAttributedText(string: text))
                    .foregroundColor(Asset.Colors.thirdFontColor.swiftUIColor.opacity(0.65))
                    .xlFont(weight: .semibold)
                
                Text(Strings.doYouUseApp)
                    .foregroundColor(Asset.Colors.thirdFontColor.swiftUIColor)
                    .xlFont(weight: .semibold)
                    .padding(.top, 24)
                
                Spacer()
                
                content
            }
            .padding(.top, 120)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .background(Asset.Colors.additionalBackground.swiftUIColor)
        }
    }
    
    func getHelloAttributedText(string: String) -> AttributedString {
        guard text == Strings.helloText else {
            return AttributedString.init(stringLiteral: string)
        }

        var attributedString = AttributedString.init(stringLiteral: string)
        let range = attributedString.range(of: "Jumpeak")!
        attributedString[range].foregroundColor = Asset.Colors.thirdFontColor.swiftUIColor
        return attributedString
    }
}
