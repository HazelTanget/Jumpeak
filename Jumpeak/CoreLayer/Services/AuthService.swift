//
//  AuthService.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import Combine
import FirebaseAuth

protocol FirebaseAuthService {
    func login(with credentials: LoginCredentials) -> AnyPublisher<Void, Error>
}

final class FirebaseAuthServiceImpl: FirebaseAuthService {
    let auth = Auth.auth()
    
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
