//
//  HardSkill.swift
//  Jumpeak
//
//  Created by Денис Большачков on 25.04.2023.
//

import FirebaseFirestoreSwift

struct HardSkill: Codable {
    @DocumentID var id: String?
    var name: String
}
