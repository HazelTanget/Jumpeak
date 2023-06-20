//
//  ProjectsView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 19/06/23.
//

import SwiftUI

struct ProjectsView: View {
    @ObservedObject var viewModel = ApplicationAssemby.defaultContainer.resolve(SecondStepViewModel.self)!
    @State private var selection: Int?
    
    var body: some View {
        SkillsStepView(stepContent: {
            ForEach(viewModel.projects, id: \.id) { project in
                buildOneProjectItem(project: project)
            }
            
            Spacer()
        }, showAddingButton: true, firstButtonTitle: "", secondButtonTitle: "", firstButtonAction: {
            
        },secondButtonAction: {
            viewModel.shouldShowThirdStep = true
        })
        .navigationDestination(isPresented: $viewModel.shouldShowThirdStep, destination: {
            CommonInfoView(text: "Портфолио создано, остался всего один шаг!", descriptionText: "Запиши небольшое видео и кратко расскажи о себе: чем ты увлекаешься, почему выбрал эту профессию и какой-нибудь забавный факт о себе") {
                HStack {
                    NavigationLink (destination: CameraView(userId: viewModel.userId ?? "").navigationBarBackButtonHidden(true), tag: 2, selection: $selection, label: {
                        AccentButton(text: "Записать видео-резюме!",
                                     foregroundColor: Asset.Colors.mainFontColor.swiftUIColor,
                                     backgroundColor: Asset.Colors.background.swiftUIColor) {
                            selection = 2
                        }
                    })
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 51)
            }
            .navigationBarBackButtonHidden(true)
        })
        .onAppear {
            viewModel.getProjects()
        }
        .navigationTitle(Strings.secondStepPorfolio)
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading){
                BackBarButton()
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
//                    viewModel.shouldShowProjectList = true
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                }

            }
        }
        .background(Asset.Colors.background.swiftUIColor)
        .preferredColorScheme(.light)
        
        
    }
    
    @ViewBuilder
    private func buildOneProjectItem(project: Project) -> some View {
        HStack {
            VStack (alignment: .leading) {
                Text(project.projectTitle ?? "")
                    .mFont(weight: .medium)
                    .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                
                HStack {
                    if project.gitHubLink != nil {
                        Button {
                            
                        } label: {
                            HStack {
                             Image(systemName: "link")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(Asset.Colors.accentColor.swiftUIColor)

                                Text("Проект на GitHub")
                                    .sFont(weight: .medium)
                                    .foregroundColor(Asset.Colors.accentColor.swiftUIColor)
                            }
                            
                        }
                        
                        Circle()
                            .fill(Asset.Colors.mainFontColor.swiftUIColor.opacity(0.5))
                            .frame(width: 4, height: 4)
                            .padding(.leading, 14)
                            .padding(.trailing, 14)
                            
                    }
                    
                    Text("iOS разработчик")
                        .sFont(weight: .medium)
                        .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                }
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "chevron.forward")
                    .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                    .fontWeight(.medium)
            }
            .frame(width: 24, height: 24)

        }
        .background(Asset.Colors.background.swiftUIColor)
        .frame(maxWidth: .infinity)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
