//
//  Project.swift
//  Jumpeak
//
//  Created by Денис Большачков on 15/06/23.
//

import FirebaseFirestoreSwift

struct Project: Codable {
    @DocumentID var id: String?
    var projectTitle: String?
    var projectDescription: String?
    var gitHubLink: String?
    var userId: String?
}
