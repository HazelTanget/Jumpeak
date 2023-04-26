//
//  SoftSkillsService.swift
//  Jumpeak
//
//  Created by Денис Большачков on 26.04.2023.
//

import Combine
import FirebaseFirestore

protocol SoftSkillsService {
    func getSoftSkills() -> AnyPublisher<[SoftSkill], Error>
}

final class SoftSkillsServiceImpl: SoftSkillsService {
    func getSoftSkills() -> AnyPublisher<[SoftSkill], Error> {
        Deferred {
            Future { [weak self] promise in
                Firestore.firestore()
                    .collection(FirebaseCollection.softSkills.rawValue)
                    .getDocuments { snapshot, error in
                        guard let documents = snapshot?.documents else {
                            print("Error fetching documents: \(error!)")
                            return
                        }
                        
                        let softSkills = documents.compactMap { queryDocumentSnapshot -> SoftSkill? in
                            return try? queryDocumentSnapshot.data(as: SoftSkill.self)
                        }
                        
                        promise(.success(softSkills))
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
