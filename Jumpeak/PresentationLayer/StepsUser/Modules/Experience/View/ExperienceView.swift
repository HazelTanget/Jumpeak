//
//  ExperienceView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 27.05.2023.
//

import SwiftUI

struct ExperienceView: View {
    
    @ObservedObject var viewModel = ApplicationAssemby.defaultContainer.resolve(ExperienceViewModel.self)!
    
    //For change date text
    @State private var startDateText = ""
    @State private var endDateText = ""
    
    @Environment(\.dismiss) private var dismiss
    
    private let formatter = DateFormatter()

    var body: some View {
        VStack(spacing: 16) {
            BackBarButton()
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(Strings.tellMoreAboutIt)
                .lFont(weight: .medium)
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40)
                .onAppear {
                    formatter.dateFormat = "dd.MM.yyyy"
                }
            
            textFields
            
            dates
            
            toggle
            
            
            Spacer()
            
            buttons
        }
        .padding(.horizontal, 16)
        .fullScreenCover(isPresented: $viewModel.isNeedToOpenExpView) {
            ExperienceView()
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    viewModel.isNeedToOpenExpView = false
                }
        }
        .background(
            Asset.Colors.background.swiftUIColor
        )
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .ignoresSafeArea(.keyboard)
        
    }
    
    var textFields: some View {
        VStack {
            CustomTextField(placeholder: "Название компании", text: $viewModel.editingExp.companyName)
            
            CustomTextField(placeholder: "Должность", text: $viewModel.editingExp.position)
            
            CustomTextField(placeholder: "Чест ты там занимался ?(необязательно)", text: Binding($viewModel.editingExp.descritpion)!)
        }
    }
    
    var dates: some View {
        HStack (spacing: 16) {
            CustomTextField(placeholder: "Дата начала",  isDateField: true, text: $viewModel.startDateText, date: $viewModel.editingExp.startDate)
                .onChange(of: viewModel.editingExp.startDate) { newValue in
                    viewModel.startDateText = formatter.string(from: newValue)
                }
            if viewModel.editingExp.isStillWorking == false {
                CustomTextField(placeholder: "Дата окончания", isDateField: true, text: $viewModel.endDateText, date: $viewModel.editingExp.endDate)
                    .onChange(of: viewModel.editingExp.endDate) { newValue in
                        viewModel.endDateText = formatter.string(from: newValue)
                    }
            }
        }
    }
    
    var toggle: some View {
        HStack {
            ZStack {
                if !viewModel.editingExp.isStillWorking {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 1.5)
                        .fill(Asset.Colors.accentColor.swiftUIColor)
                        .frame(width: 20, height: 20)
                } else {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Asset.Colors.accentColor.swiftUIColor)
                        .frame(width: 20, height: 20)
                }
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    viewModel.editingExp.isStillWorking.toggle()
                    viewModel.editingExp.endDate = Date()
                }
            }
         
            Text("Работаю по настоящее время")
                .sFont()
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
            
            Spacer()
        }
    }
    
    var buttons: some View {
        VStack {
            AccentButton(text: "Есть еще другой опыт", foregroundColor: Asset.Colors.accentColor.swiftUIColor, backgroundColor: Asset.Colors.inputColor.swiftUIColor, isEnable: $viewModel.isEnableButtonNextAndAddExp) {
                viewModel.addAnotherExperience()
            }
            
            AccentButton(text: "Далее", isEnable: $viewModel.isEnableButtonNextAndAddExp) {
                viewModel.nextButtonTapped()
                dismiss()
            }
        }
    }
}

struct ExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceView()
    }
}
