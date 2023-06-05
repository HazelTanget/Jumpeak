//
//  ExperienceUser.swift
//  Jumpeak
//
//  Created by Денис Большачков on 03.06.2023.
//

import FirebaseFirestoreSwift

struct ExperienceUser: Codable {
    @DocumentID var id: String?
    var companyName: String
    var position: String
    /// in this field user add info about what he did do in work
    var descritpion: String?
    var startDate: Date
    var endDate: Date
    var isStillWorking: Bool
    var userId: String
    
    static var newExp = ExperienceUser(companyName: "", position: "", descritpion: "", startDate: Date(), endDate: Date(), isStillWorking: false, userId: "")
}
