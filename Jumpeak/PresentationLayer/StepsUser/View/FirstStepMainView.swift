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
            
            secondStep
            
            thirdStep
            
            fourthStep
        }
        .tabViewStyle(.page)
        .background(Asset.Colors.background.swiftUIColor)
        .onAppear {
            viewModel.fetchSubjects()
            viewModel.fetchProffessions()
            viewModel.fetchHardSkills()
            viewModel.fetchSoftSkills()
        }
    }
    
    var firstStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.subject)
                .padding(.top, 16)
            
        } action: {
            
        }
        .tag(0)
    }
    
    var secondStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.proffessions)
                .padding(.top, 16)
            
        } action: {
            
        }
        .tag(1)
    }
    
    var thirdStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.hardSkills)
                .padding(.top, 16)
            
        } action: {
            
        }
        .tag(2)
    }
    
    var fourthStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $searchText)
            
            LayoutTags(tag: $viewModel.softSkills)
                .padding(.top, 16)
            
        } action: {
            
        }
        .tag(3)
    }
}

struct FirstStepMainView_Previews: PreviewProvider {
    static var previews: some View {
        FirstStepMainView()
    }
}
