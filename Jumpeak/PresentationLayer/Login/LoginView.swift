//
//  LoginView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var viewModel = ApplicationAssemby.defaultContainer.resolve(LoginViewModel.self)!
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont.systemFont(ofSize: 16)]
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Asset.Colors.inputColor.swiftUIColor)
                
                Text("👮")
                    .font(.system(size: 40))
            }
            .frame(width: 168, height: 168)
            .padding(.top, 40)
            .ignoresSafeArea(.keyboard)

            inputFields
            
            Spacer()
            
            enterArea
        }
        .alert(isPresented: $viewModel.hasErrors) {
            if case .failed(let error) = viewModel.state {
                return Alert(title: Text("Ошибка"),
                             message: Text(error.localizedDescription))
            } else {
                return Alert(title: Text("Ошибка"),
                             message: Text("Что-то пошло не так"))
            }
        }
        .navigationTitle(Strings.enter)
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading){
                BackBarButton()
            }
        }
        .background(
            Asset.Colors.background.swiftUIColor
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
        )
        .preferredColorScheme(.light)
        .ignoresSafeArea(.keyboard)
    }
    
    var inputFields: some View {
        VStack {
            CustomTextField(placeholder: Strings.email, text: $viewModel.credentials.email)
            CustomTextField(placeholder: Strings.password, text: $viewModel.credentials.password, isSecure: true)
                .padding(.top, 16)
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }
    
    var enterArea: some View {
        VStack {
            AccentButton(text: Strings.enter, foregroundColor: Asset.Colors.thirdFontColor.swiftUIColor) {
                viewModel.login()
            }

            Button {
                
            } label: {
                Text(Strings.cantGetIn)
                    .mFont(weight: .medium)
                    .foregroundColor(Asset.Colors.accentColor.swiftUIColor)
            }
            .padding(.top, 16)

        }
        .padding(.bottom, 24)
        .padding(.horizontal, 16)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
