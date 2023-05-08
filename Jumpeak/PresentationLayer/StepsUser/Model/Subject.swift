//
//  Subject.swift
//  Jumpeak
//
//  Created by Денис Большачков on 26.04.2023.
//

import FirebaseFirestoreSwift

struct Subject: Codable, Equatable {
    @DocumentID var id: String?
    var name: String
    var professionsId: [String]
}

