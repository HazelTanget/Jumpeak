//
//  SecondStepView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 11/06/23.
//

import SwiftUI

//TODO: https://stackoverflow.com/questions/2514859/regular-expression-for-git-repository

struct SecondStepView: View {
    @ObservedObject var viewModel = ApplicationAssemby.defaultContainer.resolve(SecondStepViewModel.self)!
    
    var body: some View {
        NavigationStack (path: $viewModel.navigationPath) {
            TabView(selection: $viewModel.selection) {
                firstStep
            }
        }
        .alert("Git hub link", isPresented: $viewModel.shouldPresentGitHubSheet, actions: {
            TextField("Link", text: $viewModel.gitHubLink)
            
            Button("Enter", action: {})
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("Please enter git hub link portfolio.")
        })
        .navigationTitle(Strings.secondStepPorfolio)
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading){
                BackBarButton()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.shouldShowMenu.toggle()
                } label: {
                    Image(systemName: "list.dash")
                }

            }
        }
        .fullScreenCover(isPresented: $viewModel.shouldShowMenu) {
            StepMenu()
        }
        .background(Asset.Colors.background.swiftUIColor)
    }

    var firstStep: some View {
        SkillsStepView {
            TextField("Название проекта", text: $viewModel.projectName)
                .xlFont(weight: .semibold)
            
            TextField("Описание проекта", text: $viewModel.projectDescription)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button {
                            viewModel.shouldPresentGitHubSheet.toggle()
                        } label: {
                            Image(systemName: "link")
                                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                                .frame(width: 24, height: 24)
                        }

                    }
                }
                
            
        } action: {
            
        }
        .tag(1)
    }
}

struct SecondStepView_Previews: PreviewProvider {
    static var previews: some View {
        SecondStepView()
    }
}


struct AddGitHubSheet: View {
    var body: some View {
        VStack {
            
        }
    }
}
