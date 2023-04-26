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

    init(title: String, descriptionTitle: String, descriptionContent: String = "", @ViewBuilder stepContent: () -> T, action: @escaping () -> ()) {
        self.title = title
        self.descriptionTitle = descriptionTitle
        self.descriptionContent = descriptionContent
        self.stepContent = stepContent()
        self.action = action
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
            
            AccentButton(text: Strings.next) {
                action()
            }
            .padding(.bottom, 22)
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
