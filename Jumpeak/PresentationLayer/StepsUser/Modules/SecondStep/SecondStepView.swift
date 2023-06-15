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
            uploadView
        }
        .navigationDestination(for: Views.self, destination: { view in
            if view == .projectList {
                
            }
        })
        .alert("Git hub link", isPresented: $viewModel.shouldPresentGitHubSheet, actions: {
            TextField("Link", text: $viewModel.gitHubLink)
            
            Button("Enter", action: {
                viewModel.saveLink()
            })
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("Please enter git hub link portfolio.")
        })
        .alert(isPresented: $viewModel.hasErrors) {
            Alert(title: Text("Ошибка"),
                  message: Text("Укажите корректную ссылку"))
        }
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
                        .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                }

            }
        }
        .fullScreenCover(isPresented: $viewModel.shouldShowMenu) {
            StepMenu()
        }
        .background(Asset.Colors.background.swiftUIColor)
    }

    var uploadView: some View {
        SkillsStepView {
            if viewModel.editProject.gitHubLink?.isEmpty ?? true == false {
                Button {
                    viewModel.didTapLinkButton()
                } label: {
                    HStack {
                        Image(systemName: "link")
                            .foregroundColor(Asset.Colors.accentColor.swiftUIColor)
                            .frame(width: 16, height: 16)

                        Text("Проект на GitHub")
                            .sFont(weight: .medium)
                            .foregroundColor(Asset.Colors.accentColor.swiftUIColor)
                    }
                }
            }
            
            TextField("Название проекта", text: $viewModel.editProject.projectTitle.toUnwrapped(defaultValue: ""))
                .xlFont(weight: .semibold)
            
            TextField("Описание проекта", text: $viewModel.editProject.projectDescription.toUnwrapped(defaultValue: ""))
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
            viewModel.didTapNextButton()
        }
    }
    
    var projectList: some View {
        NavigationStack(path: $viewModel.prjListNavigationPath) {
            SkillsStepView(stepContent: {
                
                
            }, showAddingButton: true) {
                
            } secondButtonAction: {
                
            }
        }
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading){
                BackBarButton()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.shouldShowMenu.toggle()
                } label: {
                    Image(systemName: "list.dash")
                        .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                }

            }
        }
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
