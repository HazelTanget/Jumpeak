//
//  Proffession.swift
//  Jumpeak
//
//  Created by Денис Большачков on 26.04.2023.
//

import FirebaseFirestoreSwift

struct Profession: Codable {
    @DocumentID var id: String?
    var name: String
}

