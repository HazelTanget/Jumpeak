//
//  User.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    var email: String
    
    enum CodingKeys: String, CodingKey {
        case email = "Email"
    }
}

extension User {
    static var new: User {
        User(email: "")
    }
}
