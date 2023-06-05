//
//  SkillsMainView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 25.04.2023.
//

import SwiftUI

struct SkillsStepView<T: View>: View {
    var title: String
    var descriptionTitle: String
    var descriptionContent: String
    var stepContent: T
    var action: () -> ()
    var showAddingButton: Bool
    var firstButtonTitle: String
    var secondButtonTitle: String
    var firstButtonAction: () -> ()
    var secondButtonAction: () -> ()

    init(title: String,
         descriptionTitle: String,
         descriptionContent: String = "",
         @ViewBuilder stepContent: () -> T,
         action: @escaping () -> () = {},
         showAddingButton: Bool = false,
         firstButtonTitle: String = "",
         secondButtonTitle: String = "",
         firstButtonAction: @escaping () -> () = {},
         secondButtonAction: @escaping () -> () = {}) {
        self.title = title
        self.descriptionTitle = descriptionTitle
        self.descriptionContent = descriptionContent
        self.stepContent = stepContent()
        self.action = action
        self.showAddingButton = showAddingButton
        self.firstButtonAction = firstButtonAction
        self.secondButtonAction = secondButtonAction
        self.firstButtonTitle = firstButtonTitle
        self.secondButtonTitle = secondButtonTitle
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .lFont()
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                .padding(.top, 40)
            
            Text(descriptionTitle)
                .mFont()
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor.opacity(0.5))
                .padding(.top, 8)
            
            stepContent
            
            Spacer()
            
            if !showAddingButton {
                AccentButton(text: Strings.next) {
                    action()
                }
                .padding(.bottom, 22)
            } else {
                HStack {
                    AccentButton(text: firstButtonTitle, foregroundColor: Asset.Colors.accentColor.swiftUIColor, backgroundColor: Asset.Colors.inputColor.swiftUIColor) {
                        firstButtonAction()
                    }
                    
                    AccentButton(text: secondButtonTitle) {
                        secondButtonAction()
                    }
                }
                .padding(.bottom, 22)
            }
        }
        .background(Asset.Colors.background.swiftUIColor)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .padding(.horizontal, 16)
        
    }
}

struct SkillsStepView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsStepView(title: "Выбери в какой области хочешь работать?", descriptionTitle: "Выбери область. Одну или несколько") {
            
        } action: {
            
        }

    }
}
