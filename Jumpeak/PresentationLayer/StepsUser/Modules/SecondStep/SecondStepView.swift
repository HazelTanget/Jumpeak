//
//  SecondStepView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 11/06/23.
//

import SwiftUI

struct SecondStepView: View {
    @ObservedObject var viewModel = ApplicationAssemby.defaultContainer.resolve(SecondStepViewModel.self)!
    
    var body: some View {
        uploadView
            .navigationDestination(isPresented: $viewModel.shouldShowProjectList, destination: {
                ProjectsView()
                    .navigationBarBackButtonHidden(true)
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
                        viewModel.uploadProject()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                    }
                    
                }
            }
            .fullScreenCover(isPresented: $viewModel.shouldShowMenu) {
                StepMenu()
            }
            .background(Asset.Colors.background.swiftUIColor)
            .preferredColorScheme(.light)
    }

    var uploadView: some View {
        VStack {
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
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            TextField("Название проекта", text: $viewModel.editProject.projectTitle.toUnwrapped(defaultValue: ""))
                .xlFont(weight: .semibold)
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
            
            TextField("Описание проекта", text: $viewModel.editProject.projectDescription.toUnwrapped(defaultValue: ""))
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
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
                
            Spacer()
        }
        .background(Asset.Colors.background.swiftUIColor)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .padding(.horizontal, 16)
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
