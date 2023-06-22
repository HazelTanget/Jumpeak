//
//  StepMenu.swift
//  Jumpeak
//
//  Created by Денис Большачков on 06/06/23.
//

import SwiftUI
import Kingfisher

struct StepMenu: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel = ApplicationAssemby.defaultContainer.resolve(StepMenuViewModelImpl.self)!

    var body: some View {
        VStack {
            userInfo
                .onAppear {
                    viewModel.getURL()
                }

            Text(Strings.checkWhatNeedToBoss)
                .mFont()
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor.opacity(0.4))
                .padding(.top, 80)
                .padding(.horizontal, 16)
            
            resumeInfo
                .padding(.top, 24)
            
            Spacer()
        }
        .navigationTitle(Strings.stepMenuTitle)
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading){
                BackBarButton()
            }
        }
        .background(
            Asset.Colors.background.swiftUIColor
        )
        .onTapGesture {
            dismiss()
        }
    }
    
    var userInfo: some View {
        VStack {
            KFImage(viewModel.url)
                .placeholder({
                    Circle()
                        .fill(Asset.Colors.inputColor.swiftUIColor)
                        .frame(width: 88, height: 88)
                })
                .resizable()
                .scaledToFill()
                .frame(width: 88, height: 88)
                .clipShape(Circle())
            
            Text("\(viewModel.user?.lastName ?? "") \(viewModel.user?.firstName ?? "") \(viewModel.user?.middleName ?? "")")
                .mFont()
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                .padding(.top, 8)
            
            Text("\(viewModel.userData?.selectedProffessions.first?.name ?? "")")
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
                Text(Strings.completedSteps("\(getCount(info: resumeType))", resumeType.maxCountOfStep))
                    .foregroundColor(calculateColor(info: resumeType))
                    .sFont(weight: .medium)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(calculateColor(info: resumeType))
                        .frame(height: 4)
   
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Asset.Colors.background.swiftUIColor)
                        .frame(height: 4)
                }
                
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
    
    func calculateColor(info: InfoUserResume) -> Color {
        switch info {
        case .baseInfo:
            switch viewModel.countOfBaseInfo {
            case 0..<2:
                return Asset.Colors.errorColor.swiftUIColor
            case 0..<4:
                return Asset.Colors.warningColor.swiftUIColor
            case 0..<6:
                return Asset.Colors.successColor.swiftUIColor
            default: return Asset.Colors.successColor.swiftUIColor
            }
        case .portfolio:
            switch viewModel.countOfPortfolio {
            case 0..<1:
                return Asset.Colors.warningColor.swiftUIColor
            case 0..<2:
                return Asset.Colors.successColor.swiftUIColor
            default: return Asset.Colors.warningColor.swiftUIColor
            }
        case .video:
            switch viewModel.countOfVideoInfo {
            case 1..<2:
                return Asset.Colors.successColor.swiftUIColor
            default:
                return Asset.Colors.warningColor.swiftUIColor
            }
        }
    }
    
    func getCount(info: InfoUserResume) -> Int {
        switch info {
        case .baseInfo: return viewModel.countOfBaseInfo
        case .portfolio: return viewModel.countOfPortfolio
        case .video: return viewModel.countOfVideoInfo
        }
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
    
    var maxCountOfStep: String {
        switch self {
        case .baseInfo: return "6"
        case .portfolio: return "2"
        case .video: return "1"
        }
    }
}
