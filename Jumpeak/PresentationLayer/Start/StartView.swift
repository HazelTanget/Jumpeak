//
//  StartView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import SwiftUI

struct StartView: View {
    @State private var selection: Int?
    
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
                    NavigationLink (destination: LoginView().navigationBarBackButtonHidden(true), tag: 1, selection: $selection, label: {
                        AccentButton(text: Strings.enter,
                                     foregroundColor: Asset.Colors.thirdFontColor.swiftUIColor,
                                     backgroundColor: Asset.Colors.background.swiftUIColor.opacity(0.2)) {
                            selection = 1
                        }
                    })

                    NavigationLink (destination: RegistrationMainView().navigationBarBackButtonHidden(true), tag: 2, selection: $selection, label: {
                        AccentButton(text: Strings.createAccount,
                                     foregroundColor: Asset.Colors.mainFontColor.swiftUIColor,
                                     backgroundColor: Asset.Colors.background.swiftUIColor) {
                            selection = 2
                        }
                    })
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
