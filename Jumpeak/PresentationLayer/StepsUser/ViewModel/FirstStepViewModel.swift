//
//  FirstStepViewModel.swift
//  Jumpeak
//
//  Created by Денис Большачков on 25.04.2023.
//

import Foundation
import Combine

class FirstStepViewModel: ObservableObject {
    var allHardSkills: [HardSkill] = []
    var allProffessions: [Profession] = []
    var allSubject: [Subject] = []
    var allSoftSkills: [SoftSkill] = []
    
    @Published var hardSkills: [Tag] = []
    @Published var proffessions: [Tag] = []
    @Published var subject: [Tag] = []
    @Published var softSkills: [Tag] = []
    @Published var selectedSkills: [HardSkill] = []
    
    @Published var selection = 0
    
    //Selected data
    var selectedData = SelectedFirstDataUser()
    
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
                case .failure(_):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { [unowned self] skills in
                var filteredHardSkills: [HardSkill] = []
                skills.forEach { skill in
                    self.selectedData.selectedProffessions.forEach { prof in
                        prof.hardSkillsId.forEach { hardSkillId in
                            if hardSkillId == skill.id {
                                filteredHardSkills.append(skill)
                            }
                        }
                    }
                }
                
                self.allHardSkills = filteredHardSkills
                
                var tags = filteredHardSkills.compactMap { Tag(id: $0.id ?? UUID().uuidString, name: $0.name) }
                tags.append(Tag(name: "+"))
                self.hardSkills = tags
            }
            .store(in: &subscriptions)
    }
    
    func fetchProffessions() {
        professionsService.getProfessions()
            .sink { [weak self] res in
                switch res {
                case .failure(_):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { [unowned self] proffessions in
                var filtered = [Profession]()
                proffessions.forEach { prof  in
                    self.selectedData.selectedSubject.forEach { subject in
                        subject.professionsId.forEach { id in
                            if prof.id == id {
                                filtered.append(prof)
                            }
                        }
                    }
                }
                self.allProffessions = filtered
                
                var tags = filtered.compactMap { Tag(id: $0.id ?? UUID().uuidString, name: $0.name) }
                tags.append(Tag(name: "+"))
                self.proffessions = tags
            }
            .store(in: &subscriptions)
    }
    
    func fetchSubjects() {
        subjectService.getSubjects()
            .sink { [weak self] res in
                switch res {
                case .failure(_):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { [unowned self] subjects in
                self.allSubject = subjects
                var tags = subjects.compactMap { Tag(id: $0.id ?? UUID().uuidString, name: $0.name) }
                tags.append(Tag(name: "+"))
                self.subject = tags
            }
            .store(in: &subscriptions)
    }
    
    func fetchSoftSkills() {
        softSkillsService.getSoftSkills()
            .sink { [weak self] res in
                switch res {
                case .failure(_):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { softSkills in
                self.allSoftSkills = softSkills
                var tags = softSkills.compactMap { Tag(id: $0.id ?? UUID().uuidString, name: $0.name) }
                tags.append(Tag(name: "+"))
                self.softSkills = tags
            }
            .store(in: &subscriptions)
    }
    
    func nextFirstButtonTapped() {
        let subjects = subject.filter { $0.isSelected }
        var appendedSubjects: [Subject] = []
        allSubject.forEach { allSubject in
            subjects.forEach { subject in
                if subject.id == allSubject.id {
                    appendedSubjects.append(allSubject)
                }
            }
        }
        
        selectedData.selectedSubject = appendedSubjects
        
        if selectedData.selectedSubject.count == 0 {
            hasErrors = true
        }
        
        selection += 1
    }
    
    func secondButtonTapped() {
        let proffession = proffessions.filter { $0.isSelected }
        var appendedProffession: [Profession] = []
        allProffessions.forEach { allProffession in
            proffession.forEach { proff in
                if allProffession.id == proff.id {
                    appendedProffession.append(allProffession)
                }
            }
        }
        
        selectedData.selectedProffessions = appendedProffession
        
        if selectedData.selectedProffessions.count == 0 {
            hasErrors = true
        }
        
        selection += 1
    }
    
    func thirdButtonTapped() {
        let hardSkills = hardSkills.filter { $0.isSelected }
        var appendedHardSkills: [HardSkill] = []
        allHardSkills.forEach { allHardSkill in
            hardSkills.forEach { hardSkill in
                if allHardSkill.id == hardSkill.id {
                    appendedHardSkills.append(allHardSkill)
                }
            }
        }
        
        selectedData.selectedHardSkills = appendedHardSkills
        
        if selectedData.selectedProffessions.count == 0 {
            hasErrors = true
        }
        
        selection += 1
    }
    
    func fourthButtonTapped() {
        let softSkills = softSkills.filter { $0.isSelected }
        var appendedSoftSkills: [SoftSkill] = []
        allSoftSkills.forEach { allSoftSkill in
            softSkills.forEach { softSkill in
                if allSoftSkill.id == softSkill.id {
                    appendedSoftSkills.append(allSoftSkill)
                }
            }
        }
        
        selectedData.selectedSoftSkills = appendedSoftSkills
        
        if selectedData.selectedProffessions.count == 0 {
            hasErrors = true
        }
        
        selection += 1
    }
}

