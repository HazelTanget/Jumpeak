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
    @Published var savedData: SelectedFirstDataUser?
    
    @Published var userID: String?
    @Published var shouldShowAuthView: Bool = true

    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        setupAuthHandler()
        checkValue()
    }
    
    func logout() {
        shouldShowAuthView = true
        updateState()
    }
    
    func updateState() {
        state = shouldShowAuthView ? .loggedOut : .loggedIn
        UserDefaults.standard.set(shouldShowAuthView, forKey: "shouldShowAuthView")
    }
    
    func saveDate(userDetails: UnregistredUsers) {
        self.userDetails = userDetails
        do {
            let data = try JSONEncoder().encode(userDetails)
            UserDefaults.standard.set(data, forKey: "userDetail")
        } catch let error {
            print("Error encoding: \(error)")
        }
    }
    
    func saveUserData(userData: SelectedFirstDataUser) {
        self.savedData = userData
        do {
            let data = try JSONEncoder().encode(userData)
            UserDefaults.standard.set(data, forKey: "userData")
        } catch let error {
            print("Error encoding: \(error)")
        }
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

                self?.state = self?.shouldShowAuthView ?? true ? .loggedOut : .loggedIn
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
    
    func checkValue() {
        let value = UserDefaults.standard.bool(forKey: "shouldShowAuthView")
        shouldShowAuthView = value
        
        do {
            if let data = UserDefaults.standard.data(forKey: "userDetail") {
                self.userDetails = try JSONDecoder().decode(UnregistredUsers.self, from: data)
                
            }
            
            if let data = UserDefaults.standard.data(forKey: "userData") {
                self.savedData = try JSONDecoder().decode(SelectedFirstDataUser.self, from: data)
                
            }
        } catch let error {
            print("Error decoding: \(error)")
        }
        
        guard let userDetails = userDetails, let savedData = savedData else { return }
        
        let stepViewModel = ApplicationAssemby.defaultContainer.resolve(StepMenuViewModelImpl.self)
        stepViewModel?.configure(with: userDetails)
        stepViewModel?.configure(with: savedData)
    }
}
