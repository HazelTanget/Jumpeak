//
//  HardSkillsService.swift
//  Jumpeak
//
//  Created by Денис Большачков on 25.04.2023.
//

import Combine
import FirebaseFirestore

protocol HardSkillsService {
    func getHardSkills() -> AnyPublisher<[HardSkill], Error>
}

final class HardSkillsServiceImpl: HardSkillsService {
    func getHardSkills() -> AnyPublisher<[HardSkill], Error> {
        Deferred {
            Future { [weak self] promise in
                Firestore.firestore()
                    .collection(FirebaseCollection.hardSkills.rawValue)
                    .getDocuments { snapshot, error in
                        guard let documents = snapshot?.documents else {
                            print("Error fetching documents: \(error!)")
                            return
                        }
                        
                        let hardSkills = documents.compactMap { queryDocumentSnapshot -> HardSkill? in
                            return try? queryDocumentSnapshot.data(as: HardSkill.self)
                        }
                        
                        promise(.success(hardSkills))
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
