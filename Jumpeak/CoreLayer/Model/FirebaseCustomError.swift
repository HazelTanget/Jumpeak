//
//  FirebaseCustomError.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import Foundation

struct FirebaseCustomErrorO: Error, Identifiable {
    var id = UUID()
    
    var emoji: String
    var title: String
}

enum FirebaseCustomError: Error {
    case userDoesntExits
    case passwordsDoesntMatch
}

extension FirebaseCustomError {
    var errorO: FirebaseCustomErrorO {
        get {
            switch self {
            case .userDoesntExits:
                return FirebaseCustomErrorO(emoji: "😔", title: Strings.userDoesntExsist)
            case .passwordsDoesntMatch:
                return FirebaseCustomErrorO(emoji: "😔", title: Strings.passwordDontMatch)
            }
        }
        set {
            
        }
    }
}


//extension FirebaseCustomError: LocalizedError {
//    public var errorDescription: String? {
//        switch self {
//        case .userDoesntExist:
//            return NSLocalizedString(
//                Strings.userDoesntExsist,
//                comment: ""
//            )
//        }
//    }
//
//    public var emoji: String {
//        switch self {
//        case .userDoesntExist:
//            return "😔"
//        }
//    }
//}
//
