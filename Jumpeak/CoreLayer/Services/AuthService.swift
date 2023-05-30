//
//  AuthService.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import Combine
import FirebaseFirestore
import FirebaseAuth

protocol FirebaseAuthService {
    func login(with credentials: LoginCredentials) -> AnyPublisher<Void, Error>
    func checkUserExist(email: String) -> AnyPublisher<UnregistredUsers, FirebaseCustomError>
    func register(oldId: String, email: String, password: String) -> AnyPublisher<Void, Error>
}

final class FirebaseAuthServiceImpl: FirebaseAuthService {
    let auth = Auth.auth()
    let firestore = Firestore.firestore()
    
    func checkUserExist(email: String) -> AnyPublisher<UnregistredUsers, FirebaseCustomError> {
        Deferred {
            Future {  [weak self] promise in
                self?.firestore
                    .collection(FirebaseCollection.unregistedUsers.rawValue)
                    .whereField(UnregistredUsers.CodingKeys.email.rawValue, isEqualTo: email)
                    .getDocuments { snapshot, error in
                        guard error != nil else {
                            guard let snapshotUser = snapshot?.documents.first else {
                                promise(.failure(FirebaseCustomError.userDoesntExits))
                                return
                            }

                            guard let user = try? snapshotUser.data(as: UnregistredUsers.self) else {
                                promise(.failure(FirebaseCustomError.userDoesntExits))
                                return
                            }

                            guard !user.isRegistred else {
                                promise(.failure(FirebaseCustomError.userWithEmailAlreadyRegistred))
                                return
                            }

                            promise(.success(user))

                            return
                        }
                        promise(.failure(FirebaseCustomError.userDoesntExits))
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func register(oldId: String, email: String, password: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { [weak self] promise in
                self?.auth
                    .createUser(withEmail: email, password: password) { [weak self] res, error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            if let id = res?.user.uid {
                                promise(.success(()))
                                let values = [UnregistredUsers.CodingKeys.isRegistred.rawValue: true]

                                Firestore.firestore().collection(FirebaseCollection.unregistedUsers.rawValue)
                                    .document(oldId).updateData(values)
                            }
                        }
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func login(with credentials: LoginCredentials) -> AnyPublisher<Void, Error> {
        Deferred {
            Future {  [weak self] promise in
                self?.auth
                    .signIn(withEmail: credentials.email, password: credentials.password) { res, error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
