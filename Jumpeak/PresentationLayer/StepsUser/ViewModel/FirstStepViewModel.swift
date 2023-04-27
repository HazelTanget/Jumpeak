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
    @Published var proffessions: [Tag] = []
    @Published var subject: [Tag] = []
    @Published var softSkills: [Tag] = []
    @Published var selectedSkills: [HardSkill] = []
    
    // Search fields
    @Published var searchHardSkills = ""
    @Published var searchSoftSkills = ""
    @Published var searchSubjects = ""
    @Published var searchProffessions = ""
    
    @Published var state = DefaultState.na

    @Published var hasErrors = false
    
    var hardSkillsService: HardSkillsService!
    var professionsService: ProfessionsService!
    var softSkillsService: SoftSkillsService!
    var subjectService: SubjectService!


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
                var tags = skills.compactMap { Tag(name: $0.name) }
                tags.append(Tag(name: "+"))
                self.hardSkills = tags
            }
            .store(in: &subscriptions)
    }
    
    func fetchProffessions() {
        professionsService.getProfessions()
            .sink { [weak self] res in
                switch res {
                case let .failure(error):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { proffessions in
                var tags = proffessions.compactMap { Tag(name: $0.name) }
                tags.append(Tag(name: "+"))
                self.proffessions = tags
            }
            .store(in: &subscriptions)
    }
    
    func fetchSubjects() {
        subjectService.getSubjects()
            .sink { [weak self] res in
                switch res {
                case let .failure(error):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { subjects in
                var tags = subjects.compactMap { Tag(name: $0.name) }
                tags.append(Tag(name: "+"))
                self.subject = tags
            }
            .store(in: &subscriptions)
    }
    
    func fetchSoftSkills() {
        softSkillsService.getSoftSkills()
            .sink { [weak self] res in
                switch res {
                case let .failure(error):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { softSkills in
                var tags = softSkills.compactMap { Tag(name: $0.name) }
                tags.append(Tag(name: "+"))
                self.softSkills = tags
            }
            .store(in: &subscriptions)
    }
}
