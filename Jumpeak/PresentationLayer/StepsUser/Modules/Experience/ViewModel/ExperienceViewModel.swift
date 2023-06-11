//
//  ExperienceViewModel.swift
//  Jumpeak
//
//  Created by Денис Большачков on 03.06.2023.
//

import Combine
import SwiftUI
import Firebase

class ExperienceViewModel: ObservableObject {
    var sessionService: SessionService!
    
    @Published var editingExp: ExperienceUser = ExperienceUser.newExp
    @Published var experiences = [ExperienceUser]()
    @Published var navigationPath = NavigationPath()
    
    @Published var startDateText = ""
    @Published var endDateText = ""
    
    var isEnableButtonNextAndAddExp: Bool {
        get {
            return !editingExp.position.isEmpty && !editingExp.companyName.isEmpty && !startDateText.isEmpty && !endDateText.isEmpty
        }
        set { self.isEnableButtonNextAndAddExp = newValue}
    }

    func addAnotherExperience() {
        navigationPath.append(Views.experience.rawValue)
    }

    func nextButtonTapped() {
        experiences.append(editingExp)
        
        uploadData()
    }

    func configure(userId: String) {
        editingExp.userId = userId
    }
    
    private func uploadData() {
        var firstStepVM = ApplicationAssemby.defaultContainer.resolve(FirstStepViewModel.self)
        firstStepVM?.selectedData.experiences = experiences
    }
}
