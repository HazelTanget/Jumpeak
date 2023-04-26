//
//  FirstStepMainView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 25.04.2023.
//

import SwiftUI

struct FirstStepMainView: View {
    @ObservedObject var viewModel = ApplicationAssemby.defaultContainer.resolve(FirstStepViewModel.self)!
    
    @State var selection = 0
    @State var searchText = ""
    
    var body: some View {
        TabView(selection: $selection) {
            firstStep
        }
        .tabViewStyle(.page)
        .background(Asset.Colors.background.swiftUIColor)
    }
    
    var firstStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.hardSkills)
                .padding(.top, 16)
                .onAppear {
                    viewModel.fetchHardSkills()
                }
            
        } action: {
            
        }
        .tag(0)
    }
    
    var secondStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.hardSkills)
                .padding(.top, 16)
                .onAppear {
                    viewModel.fetchHardSkills()
                }
            
        } action: {
            
        }
        .tag(1)
    }
    
    var thirdStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.hardSkills)
                .padding(.top, 16)
                .onAppear {
                    viewModel.fetchHardSkills()
                }
            
        } action: {
            
        }
        .tag(0)
    }
    
    var fourthStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.hardSkills)
                .padding(.top, 16)
                .onAppear {
                    viewModel.fetchHardSkills()
                }
            
        } action: {
            
        }
        .tag(0)
    }
}

struct FirstStepMainView_Previews: PreviewProvider {
    static var previews: some View {
        FirstStepMainView()
    }
}
