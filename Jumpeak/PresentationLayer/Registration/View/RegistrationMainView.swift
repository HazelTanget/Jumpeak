//
//  RegistrationMainView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 16.04.2023.
//

import SwiftUI

struct RegistrationMainView: View {
    @ObservedObject private var viewModel = ApplicationAssemby.defaultContainer.resolve(RegistrationViewModel.self)!
    
    var body: some View {
        TabView (selection: $viewModel.selection) {
            firstStepRegistration
            
            secondStepRegistration
            
            thirdStepRegistration
        }
        .tabViewStyle(.page)
        .background(Asset.Colors.background.swiftUIColor)
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading){
                if viewModel.selection == 0 {
                    BackBarButton()
                }
            }
            
            ToolbarItem(placement: .principal) {
                switch viewModel.selection {
                case 0:
                    Text(Strings.createAccount)
                case 1:
                    Text(Strings.confirmAccount)
                case 2:
                    Text(Strings.imaginePassword)
                default:
                    Text(Strings.createAccount)
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.isRegisterComplete, destination: {
            FirstStepMainView()
                .navigationBarBackButtonHidden(true)
        })
        .ignoresSafeArea(.keyboard)
        .preferredColorScheme(.light)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }

    var firstStepRegistration: some View {
        RegistrationStepView(emojiSymb: "👋", descriptionTitle: Strings.enterEmailWithPassCode, selection: $viewModel.selection) {
            
            CustomTextField(placeholder: Strings.email, fieldState: $viewModel.regFieldState, text: $viewModel.email)
                .onChange(of: viewModel.email, perform: { newValue in
                    viewModel.regFieldState = .na
                    viewModel.emailErrors = []
                })
                .padding(.top, 32)
            
            VStack {
                ForEach($viewModel.emailErrors, id: \.self) { item in
                    let item = item.errorO
                    ErrorView(emoji: item.emoji.wrappedValue, title: item.title.wrappedValue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } action: {
            viewModel.checkUserEmail()
        }
        .onChange(of: viewModel.userExists, perform: { newValue in
            if newValue {
                withAnimation {
                    viewModel.changeStep()
                }
            }
        })
        .tag(0)
    }
    
    var secondStepRegistration: some View {
        RegistrationStepView(emojiSymb: "🔑", descriptionTitle: Strings.enterEmailWithPassCode, selection: $viewModel.selection) {
        
            CodeFieldsView(codeFields: $viewModel.codeFields)
                .padding(.top, 32)

            VStack {
                ForEach($viewModel.codeError, id: \.self) { item in
                    let item = item.errorO
                    ErrorView(emoji: item.emoji.wrappedValue, title: item.title.wrappedValue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } action: {
            if viewModel.passwordValid {
                withAnimation {
                    viewModel.changeStep()
                }
            }
        }
        .onReceive(viewModel.$codeFields) { (value) in
            viewModel.codeError = []

            if !(viewModel.codeFields.last?.isEmpty ?? true) {
                viewModel.validatePassword()
            }
        }
        .tag(1)
    }

    var thirdStepRegistration: some View {
        RegistrationStepView(emojiSymb: "🔒", descriptionTitle: Strings.createStrongPass, selection: $viewModel.selection) {
            VStack (alignment: .trailing) {
                PasswordStatusView(text: $viewModel.password)
                CustomTextField(placeholder: Strings.password, text: $viewModel.password, isSecure: true)
                    .onChange(of: viewModel.password, perform: { newValue in
                        viewModel.regFieldState = .na
                        viewModel.codeError = []
                    })
            }
                .frame(maxWidth: .infinity)
                .padding(.top, 32)

            VStack {
                ForEach($viewModel.codeError, id: \.self) { item in
                    let item = item.errorO
                    ErrorView(emoji: item.emoji.wrappedValue, title: item.title.wrappedValue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        } action: {
            viewModel.registerUser()
            viewModel.impactService.callLightImpact()
        }
        .tag(2)
    }
}

struct RegistrationMainView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationMainView()
    }
}
