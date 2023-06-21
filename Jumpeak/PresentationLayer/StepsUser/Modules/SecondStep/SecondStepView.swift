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
            .alert(Strings.gitHubLink, isPresented: $viewModel.shouldPresentGitHubSheet, actions: {
                TextField(Strings.link, text: $viewModel.gitHubLink)
                
                Button(Strings.input, action: {
                    viewModel.saveLink()
                })
                Button(Strings.cancel, role: .cancel, action: {})
            }, message: {
                Text(Strings.enterGitHubLink)
            })
            .alert(isPresented: $viewModel.hasErrors) {
                if case .failed(let error) = viewModel.state {
                    return Alert(title: Text(Strings.error),
                                 message: Text(error.errorO.title))
                } else {
                    return Alert(title: Text(Strings.error),
                          message: Text(Strings.whatSoftSkillsDoUHave))
                }
            }
            .onChange(of: viewModel.editProject.projectTitle) { newValue in
                viewModel.hasErrors = false
                viewModel.state = .na
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

                        Text(Strings.gitHubLink)
                            .sFont(weight: .medium)
                            .foregroundColor(Asset.Colors.accentColor.swiftUIColor)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            TextField(Strings.nameProject, text: $viewModel.editProject.projectTitle.toUnwrapped(defaultValue: ""), axis: .vertical)
                .xlFont(weight: .semibold)
                .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                .lineLimit(2)
            
            TextField(Strings.descriptionProject, text: $viewModel.editProject.projectDescription.toUnwrapped(defaultValue: ""), axis: .vertical)
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
