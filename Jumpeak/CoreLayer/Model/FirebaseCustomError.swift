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
    case userWithEmailAlreadyRegistred
    case passwordsDoesntMatch
    case passwordLengthSmall
    case projectNameIsNil
}

extension FirebaseCustomError {
    var errorO: FirebaseCustomErrorO {
        get {
            switch self {
            case .userDoesntExits:
                return FirebaseCustomErrorO(emoji: "😔", title: Strings.userDoesntExsist)
            case .passwordsDoesntMatch:
                return FirebaseCustomErrorO(emoji: "😔", title: Strings.passwordDontMatch)
            case .userWithEmailAlreadyRegistred:
                return FirebaseCustomErrorO(emoji: "😔", title: Strings.brokenOnSteps)
            case .passwordLengthSmall:
                return FirebaseCustomErrorO(emoji: "📏", title: Strings.passwordLengthSmall)
            case .projectNameIsNil:
                return FirebaseCustomErrorO(emoji: "", title: Strings.projectNameMustntNil)
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
