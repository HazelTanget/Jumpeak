//
//  SubjectService.swift
//  Jumpeak
//
//  Created by Денис Большачков on 26.04.2023.
//

import Combine
import FirebaseFirestore

protocol SubjectService {
    func getSubjects() -> AnyPublisher<[Subject], Error>
}

final class SubjectServiceImpl: SubjectService {
    func getSubjects() -> AnyPublisher<[Subject], Error> {
        Deferred {
            Future { [weak self] promise in
                Firestore.firestore()
                    .collection(FirebaseCollection.subject.rawValue)
                    .getDocuments { snapshot, error in
                        guard let documents = snapshot?.documents else {
                            print("Error fetching documents: \(error!)")
                            return
                        }
                        
                        let subject = documents.compactMap { queryDocumentSnapshot -> Subject? in
                            return try? queryDocumentSnapshot.data(as: Subject.self)
                        }
                        
                        promise(.success(subject))
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}

