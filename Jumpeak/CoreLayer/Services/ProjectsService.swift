//
//  ProjectsService.swift
//  Jumpeak
//
//  Created by Денис Большачков on 15/06/23.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ProjectService {
    func getProjects(userId: String) -> AnyPublisher<[Project], Error>
    func uploadProject(project: Project) -> AnyPublisher<Void, Error> 
}

final class ProjectServiceImpl: ProjectService {
    func getProjects(userId: String) -> AnyPublisher<[Project], Error> {
        Deferred {
            Future { promise in
                Firestore.firestore()
                    .collection(FirebaseCollection.projects.rawValue)
                    .whereField("userId", isEqualTo: userId)
                    .getDocuments { snapshot, error in
                        guard let documents = snapshot?.documents else {
                            print("Error fetching documents: \(error!)")
                            return
                        }
                        
                        let projects = documents.compactMap { queryDocumentSnapshot -> Project? in
                            return try? queryDocumentSnapshot.data(as: Project.self)
                        }
                        
                        promise(.success(projects))
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func uploadProject(project: Project) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                let collectionRef = Firestore.firestore().collection(FirebaseCollection.projects.rawValue)
                do {
                    let newDocReference = try collectionRef.addDocument(from: project)
                    promise(.success(()))
                }
                catch {
                    print(error)
                    promise(.failure(error))
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
