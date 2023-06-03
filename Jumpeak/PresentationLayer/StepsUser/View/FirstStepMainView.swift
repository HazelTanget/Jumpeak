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
        NavigationStack (path: $viewModel.navigationPath) {
            TabView(selection: $viewModel.selection) {
                firstStep
                    .onChange(of: viewModel.searchSubjects, perform: { newValue in
                        viewModel.filterCollection(.subject)
                    })
                    .onAppear {
                        viewModel.fetchSubjects()
                    }
                
                secondStep
                    .onChange(of: viewModel.searchProffessions, perform: { newValue in
                        viewModel.filterCollection(.professions)
                    })
                    .onAppear {
                        viewModel.fetchProffessions()
                    }
                
                thirdStep
                    .onChange(of: viewModel.searchHardSkills, perform: { newValue in
                        viewModel.filterCollection(.hardSkills)
                    })
                    .onAppear {
                        viewModel.fetchHardSkills()
                    }
                
                fourthStep
                    .onChange(of: viewModel.searchSoftSkills, perform: { newValue in
                        viewModel.filterCollection(.softSkills)
                    })
                    .onAppear {
                        viewModel.fetchSoftSkills()
                    }
                
                fifthStep
                
                sixthStep
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .sheet(isPresented: $viewModel.shouldPresentImagePicker) {
                SUImagePickerView(sourceType: viewModel.shouldPresentCamera ? .camera : .photoLibrary, image: $viewModel.selectedImage, isPresented: $viewModel.shouldPresentImagePicker)
            }.actionSheet(isPresented: $viewModel.shouldPresentActionScheet) { () -> ActionSheet in
                ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                    viewModel.shouldPresentImagePicker = true
                    viewModel.shouldPresentCamera = true
                }), ActionSheet.Button.default(Text("Photo Library"), action: {
                    viewModel.shouldPresentImagePicker = true
                    viewModel.shouldPresentCamera = false
                }), ActionSheet.Button.cancel()])
            }
            .tabViewStyle(.page)
            .navigationDestination(for: String.self, destination: { view in
                if view == "ExperienceView" {
                    ExperienceView()
                }
            })
        }
        .background(Asset.Colors.background.swiftUIColor)
    }
    
    var firstStep: some View {
        SkillsStepView(title: Strings.choseYourJob, descriptionTitle: Strings.choseYourJob) {
            SearchBarView(title: Strings.enterNameArea, text: $viewModel.searchSubjects)
            
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
            SearchBarView(title: Strings.enterNameArea, text: $viewModel.searchProffessions)
            
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
            SearchBarView(title: Strings.enterNameArea, text: $viewModel.searchHardSkills)
            
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
            SearchBarView(title: Strings.enterNameArea, text: $viewModel.searchSoftSkills)
            
            LayoutTags(tag: $viewModel.softSkills)
                .padding(.top, 16)
            
        } action: {
            withAnimation {
                viewModel.fourthButtonTapped()
            }
        }
        .tag(3)
    }
    
    var fifthStep: some View {
        SkillsStepView(title: Strings.doYouHaveExp,
                       descriptionTitle: Strings.noProblemWithExp,
                       stepContent: {},
                       showAddingButton: true,
                       firstButtonTitle: Strings.notYet,
                       secondButtonTitle: Strings.yesIHave,
                       firstButtonAction: {
            withAnimation {
                viewModel.fiftButtonTapped(haveExp: false)
            }
        }, secondButtonAction: {
            withAnimation {
                viewModel.fiftButtonTapped(haveExp: true)
            }
        })
        .tag(4)
    }
    
    var sixthStep: some View {
        SkillsStepView(title: Strings.doYouHaveExp,
                       descriptionTitle: Strings.noProblemWithExp,
                       stepContent: {
            
            if let uiImage = viewModel.selectedImage,
                let photo = Image(uiImage: uiImage) {
                photo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 168, height: 168)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .center)
                
            } else {
                CircleEmojiView(emoji: "📸")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onTapGesture { viewModel.shouldPresentActionScheet = true }
            }
                
            
            
        },
                       showAddingButton: true,
                       firstButtonTitle: Strings.notYet,
                       secondButtonTitle: Strings.yesIHave,
                       firstButtonAction: {
            viewModel.sixthButtonTapped()
        }, secondButtonAction: {
            viewModel.sixthButtonTapped()
        })
        .tag(5)
    }
}

struct FirstStepMainView_Previews: PreviewProvider {
    static var previews: some View {
        FirstStepMainView()
    }
}
