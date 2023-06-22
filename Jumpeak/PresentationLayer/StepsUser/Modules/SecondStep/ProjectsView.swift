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
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(viewModel.projects, id: \.id) { project in
                        buildOneProjectItem(project: project)
                    }
                }
            }
            
            Spacer()
        }, action: {
            viewModel.shouldShowThirdStep = true
            viewModel.impactService.callLightImpact()
        })
        .navigationDestination(isPresented: $viewModel.shouldShowThirdStep, destination: {
            CommonInfoView(text: Strings.youveCreatedPortfolio, descriptionText: Strings.recordVideoDescription) {
                HStack {
                    NavigationLink (destination: CameraView(userId: viewModel.userId ?? "", userFi: "\(viewModel.userData?.lastName ?? "") \(viewModel.userData?.firstName ?? "")", userProff: viewModel.selectedData.selectedProffessions.first?.name ?? "").navigationBarBackButtonHidden(true), tag: 2, selection: $selection, label: {
                        AccentButton(text: Strings.recordVideoResume,
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
                    viewModel.shouldShowMenu = true
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
        .preferredColorScheme(.light)
        
        
    }
    
    @ViewBuilder
    private func buildOneProjectItem(project: Project) -> some View {
        HStack {
            VStack (alignment: .leading, spacing: 0) {
                Text(project.projectTitle ?? "")
                    .mFont(weight: .medium)
                    .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                
                HStack (spacing: 0) {
                    if project.gitHubLink != nil {
                        Button {
                            viewModel.didTapLinkButton(url: project.gitHubLink)
                        } label: {
                            HStack {
                             Image(systemName: "link")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(Asset.Colors.accentColor.swiftUIColor)

                                Text(Strings.gitHubLink)
                                    .sFont(weight: .medium)
                                    .foregroundColor(Asset.Colors.accentColor.swiftUIColor)
                            }
                            
                        }
                        
                        Circle()
                            .fill(Asset.Colors.mainFontColor.swiftUIColor.opacity(0.5))
                            .frame(width: 4, height: 4)
                            .padding(.leading, 14)
                            
                    }
                    
                    Text("iOS разработчик")
                        .sFont(weight: .medium)
                        .foregroundColor(Asset.Colors.mainFontColor.swiftUIColor)
                        .padding(.leading, project.gitHubLink == nil ? 0 : 14)
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
