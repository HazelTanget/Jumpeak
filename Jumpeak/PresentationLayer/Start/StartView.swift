//
//  StartView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text(getHelloAttributedText(string: Strings.helloText))
                    .foregroundColor(Asset.Colors.thirdFontColor.swiftUIColor.opacity(0.65))
                    .xlFont(weight: .semibold)
                
                Text(Strings.doYouUseApp)
                    .foregroundColor(Asset.Colors.thirdFontColor.swiftUIColor)
                    .xlFont(weight: .semibold)
                    .padding(.top, 24)
                
                Spacer()
                
                HStack {
                    AccentButton(text: Strings.enter,
                                 foregroundColor: Asset.Colors.thirdFontColor.swiftUIColor,
                                 backgroundColor: Asset.Colors.background.swiftUIColor.opacity(0.2)) {
                        
                    }

                    AccentButton(text: Strings.createAccount,
                                 backgroundColor: Asset.Colors.background.swiftUIColor) {
                        
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 51)
            }
            .padding(.top, 120)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .background(Asset.Colors.additionalBackground.swiftUIColor)
        }
    }
    
    func getHelloAttributedText(string: String) -> AttributedString {
        var attributedString = AttributedString.init(stringLiteral: string)
        let range = attributedString.range(of: "Jumpeak")!
        attributedString[range].foregroundColor = Asset.Colors.thirdFontColor.swiftUIColor
        return attributedString
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
