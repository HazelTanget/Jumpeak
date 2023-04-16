//
//  FirebaseCustomError.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import Foundation

enum FirebaseCustomError: Error {
    case userWithLoginExist
}

extension FirebaseCustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userWithLoginExist:
            return NSLocalizedString(
                "User with that login exist",
                comment: "Choose another login"
            )
        }
    }
}

