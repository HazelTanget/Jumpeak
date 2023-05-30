//
//  ExperienceView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 27.05.2023.
//

import SwiftUI

struct ExperienceView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text(Strings.tellMoreAboutIt)
                .lFont(weight: .medium)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40)
            
            CustomTextField(placeholder: "Название компании", text: .constant(""))
            
            CustomTextField(placeholder: "Должность", text: .constant(""))
            
            CustomTextField(placeholder: "Чест ты там занимался ?(необязательно)", text: .constant(""))
            
            HStack (spacing: 16) {
                CustomTextField(placeholder: "Дата начала", text: .constant(""))
                CustomTextField(placeholder: "Дата окончания", text: .constant(""))
            }
            
            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 1.5)
                    .fill(Asset.Colors.accentColor.swiftUIColor)
                    .frame(width: 20, height: 20)
             
                Text("Работаю по настоящее время")
                    .sFont()
                
                Spacer()
            }
            
            
            Spacer()
            
            AccentButton(text: "Есть еще другой опыт", foregroundColor: Asset.Colors.accentColor.swiftUIColor, backgroundColor: Asset.Colors.inputColor.swiftUIColor) {
                
            }
            
            AccentButton(text: "Далее") {
                
            }
        }
        .padding(.horizontal, 16)
    }
}

struct ExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceView()
    }
}
