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
    @Published var userDetails: UnregistredUsers?
    
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
                guard let userId = user?.uid else {
                    self?.state = .loggedOut
                    return
                }
                
                self?.state = .loggedIn
//                self.handleRefresh(userId: user?.uid)
            })
    }
    
    func handleRefresh(userId: String?) {
        Firestore.firestore().collection(FirebaseCollection.unregistedUsers.rawValue)
            .document(userId ?? "")
            .getDocument(completion: { [weak self] snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let user = try? snapshot?.data(as: UnregistredUsers.self)
                    
                    DispatchQueue.main.async {
                        self?.userID = userId
                        self?.userDetails = user

                        self?.state = user == nil ? .loggedOut : .loggedIn
                    }
                }
            })
    }
}
