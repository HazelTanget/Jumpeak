//
//  SessionService.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//
import Combine
import FirebaseAuth
import FirebaseFirestore


final class SessionService: ObservableObject {
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: User?
    
    @Published var userID: String?
    
    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        setupAuthHandler()
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

private extension SessionService {
    func setupAuthHandler() {
        handler = Auth
            .auth()
            .addStateDidChangeListener({ [weak self] res, user in
                guard let self = self else { return }
                self.handleRefresh(userId: user?.uid)
            })
    }
    
    func handleRefresh(userId: String?) {
        Firestore.firestore().collection(FirebaseCollection.users.rawValue)
            .document(userId ?? "")
            .getDocument(completion: { [weak self] snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let user = try? snapshot?.data(as: User.self)
                    
                    DispatchQueue.main.async {
                        self?.userID = userId
                        self?.userDetails = user

                        self?.state = user == nil ? .loggedOut : .loggedIn
                    }
                }
            })
    }
}
