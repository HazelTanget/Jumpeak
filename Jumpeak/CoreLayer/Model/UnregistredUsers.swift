//
//  UnregistredUsers.swift
//  Jumpeak
//
//  Created by Денис Большачков on 18.04.2023.
//

import FirebaseFirestoreSwift

struct UnregistredUsers: Codable {
    @DocumentID var id: String?
    var email: String
    var isRegistred: Bool
    var password: String
    var firstName: String
    var lastName: String
    var middleName: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, isRegistred, password, firstName, lastName, middleName
    }
}
