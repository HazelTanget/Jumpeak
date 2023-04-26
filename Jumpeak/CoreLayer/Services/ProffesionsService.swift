//
//  ProffesionsService.swift
//  Jumpeak
//
//  Created by Денис Большачков on 26.04.2023.
//

import Combine
import FirebaseFirestore

protocol ProfessionsService {
    func getProfessions() -> AnyPublisher<[Profession], Error>
}

final class ProfessionsServiceImpl: ProfessionsService {
    func getProfessions() -> AnyPublisher<[Profession], Error> {
        Deferred {
            Future { [weak self] promise in
                Firestore.firestore()
                    .collection(FirebaseCollection.professions.rawValue)
                    .getDocuments { snapshot, error in
                        guard let documents = snapshot?.documents else {
                            print("Error fetching documents: \(error!)")
                            return
                        }
                        
                        let professions = documents.compactMap { queryDocumentSnapshot -> Profession? in
                            return try? queryDocumentSnapshot.data(as: Profession.self)
                        }
                        
                        promise(.success(professions))
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
