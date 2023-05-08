//
//  FirstStepMainView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 25.04.2023.
//

import SwiftUI

struct FirstStepMainView: View {
    @ObservedObject var viewModel = ApplicationAssemby.defaultContainer.resolve(FirstStepViewModel.self)!

    @State var searchText = ""
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            firstStep
                .onAppear {
                    viewModel.fetchSubjects()
                }
            
            secondStep
                .onAppear {
                    viewModel.fetchProffessions()
                }
            
            thirdStep
                .onAppear {
                    viewModel.fetchHardSkills()
                }
            
            fourthStep
                .onAppear {
                    viewModel.fetchSoftSkills()
                }
        }
        .tabViewStyle(.page)
        .background(Asset.Colors.background.swiftUIColor)
    }
    
    var firstStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.subject)
                .padding(.top, 16)
            
        } action: {
            withAnimation {
                viewModel.nextFirstButtonTapped()
            }
        }
        .tag(0)
    }
    
    var secondStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.proffessions)
                .padding(.top, 16)
            
        } action: {
            withAnimation {
                viewModel.secondButtonTapped()
            }
        }
        .tag(1)
    }
    
    var thirdStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.hardSkills)
                .padding(.top, 16)
            
        } action: {
            withAnimation {
                viewModel.thirdButtonTapped()
            }
        }
        .tag(2)
    }
    
    var fourthStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.softSkills)
                .padding(.top, 16)
            
        } action: {
            withAnimation {
                viewModel.fourthButtonTapped()
            }
        }
        .tag(3)
    }
}

struct FirstStepMainView_Previews: PreviewProvider {
    static var previews: some View {
        FirstStepMainView()
    }
}
