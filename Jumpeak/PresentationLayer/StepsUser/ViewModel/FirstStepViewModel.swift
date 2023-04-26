//
//  FirstStepViewModel.swift
//  Jumpeak
//
//  Created by Денис Большачков on 25.04.2023.
//

import Foundation
import Combine

class FirstStepViewModel: ObservableObject {
    @Published var hardSkills: [Tag] = []
    @Published var selectedSkills: [HardSkill] = []
    
    @Published var state = DefaultState.na

    @Published var hasErrors = false
    
    var hardSkillsService: HardSkillsService!

    //MARK: Private Properties
    private var subscriptions = Set<AnyCancellable>()

    func fetchHardSkills() {
        hardSkillsService.getHardSkills()
            .sink { [weak self] res in
                switch res {
                case let .failure(error):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { skills in
                let tags = skills.compactMap { Tag(name: $0.name) }
                self.hardSkills = tags
            }
            .store(in: &subscriptions)
    }
}
