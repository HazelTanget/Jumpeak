//
//  StepMenu.swift
//  Jumpeak
//
//  Created by Денис Большачков on 06/06/23.
//

import SwiftUI
import Kingfisher

struct StepMenu: View {
    
    
    var body: some View {
        VStack {
            userInfo

            Text(Strings.checkWhatNeedToBoss)
                .mFont()
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor.opacity(0.4))
                .padding(.top, 80)
                .padding(.horizontal, 16)
            
            resumeInfo
                .padding(.top, 24)
            
            Spacer()
        }
        .background(Asset.Colors.background.swiftUIColor)
        .navigationTitle(Strings.enter)
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading){
                BackBarButton()
            }
        }
    }
    
    var userInfo: some View {
        VStack {
            Image("bg")
                .resizable()
                .scaledToFit()
                .frame(width: 88, height: 88)
                .clipShape(Circle())
            
            Text("Кирилл Кирилленко")
                .mFont()
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                .padding(.top, 8)
            
            Text("Product designer")
                .sFont()
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor.opacity(0.4))
        }
    }
    
    var resumeInfo: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(InfoUserResume.allCases, id: \.self) { item in
                        buildCompletedAddedInfoCard(resumeType: item)
                    }
                }
                .padding(.leading, 16)
            }
        }
    }
    
    @ViewBuilder
    private func buildCompletedAddedInfoCard(resumeType: InfoUserResume) -> some View {
        VStack(alignment: .leading) {
            Text(resumeType.emoji)
                .font(.system(size: 56))
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                }
            
                .padding(.top, 16)
                .padding(.leading, 16)
            
            VStack (alignment: .leading) {
                Text(Strings.completedSteps("5", "6"))
                    .foregroundColor(Asset.Colors.warningColor.swiftUIColor)
                    .sFont(weight: .medium)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Asset.Colors.warningColor.swiftUIColor)
                    .frame(height: 4)
                
                Text(resumeType.title)
                    .mFont(weight: .medium)
                    .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                
                Text(resumeType.description)
                    .mFont(weight: .medium)
                    .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor.opacity(0.4))
                
                Button {
                    
                } label: {
                    Text(Strings.open + " >")
                        .sFont(weight: .medium)
                        .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                    
                }
                .padding(.top, 24)
                .padding(.bottom, 16)
                
            }
            .frame(maxWidth: 200)
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .background(Asset.Colors.inputColor.swiftUIColor)
        .cornerRadius(8)
    }
    
    
}

struct StepMenu_Previews: PreviewProvider {
    static var previews: some View {
        StepMenu()
    }
}


enum InfoUserResume: CaseIterable {
    case baseInfo, portfolio, video
    
    var title: String {
        //TODO: вынести в localizable
        switch self {
        case .baseInfo: return "Базовая информация"
        case .portfolio: return "Портфолио"
        case .video: return "Видео-резюме"
        }
    }
    
    var description: String {
        //TODO: вынести в localizable
        switch self {
        case .baseInfo: return "Професия, навыки, опыт и фотография"
        case .portfolio: return "Добавление работ в ваше портфолио"
        case .video: return "Короткий видео-рассказ о себе"
        }
    }
    
    var emoji: String {
        //TODO: вынести в localizable
        switch self {
        case .baseInfo: return "🖋️"
        case .portfolio: return "💼"
        case .video: return "📹"
        }
    }
}
