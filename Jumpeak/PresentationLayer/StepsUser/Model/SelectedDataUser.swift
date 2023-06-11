//
//  SelectedDataUser.swift
//  Jumpeak
//
//  Created by Денис Большачков on 07.05.2023.
//

import Foundation

struct SelectedFirstDataUser: Codable {
    var userId: String?
    var selectedProffessions: [Profession] = []
    var selectedSubject: [Subject] = []
    var selectedSoftSkills: [SoftSkill] = []
    var selectedHardSkills: [HardSkill] = []
    var experiences: [ExperienceUser] = []
}
