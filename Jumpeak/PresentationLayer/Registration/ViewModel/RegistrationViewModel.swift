//
//  RegistrationViewModel.swift
//  Jumpeak
//
//  Created by Денис Большачков on 17.04.2023.
//

import FirebaseFirestore
import Combine

enum RegistrationState {
    case successful
    case failed(error: FirebaseCustomError)
    case na
}

class RegistrationViewModel: ObservableObject {
    //MARK: Public Properties
    // for view
    @Published var selection = 0
    @Published var isRegisterComplete = false
    // enter email
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var state: RegistrationState = .na
    @Published var regFieldState = TextFieldState.na
    
    // enter code
    @Published var codeFields: [String] = Array(repeating: "", count: 5)
    @Published var passwordValid = false
    @Published var codeError = [FirebaseCustomError]()
    
    // from service
    @Published var user: UnregistredUsers?
    @Published var emailErrors = [FirebaseCustomError]()
    @Published var userExists = false
    @Published var hasErrors = false

    //MARK: DI
    var service: FirebaseAuthService!

    //MARK: Private Properties
    private var subscriptions = Set<AnyCancellable>()

    func checkUserEmail() {
        emailErrors = []

        service.checkUserExist(email: email)
            .sink { res in
                switch res {
                case let .failure(error):
                    self.state = .failed(error: error)
                    self.regFieldState = .error
                    self.emailErrors.append(error)
                default: break
                }
            } receiveValue: { value in
                self.userExists = true
                self.user = value
            }
            .store(in: &subscriptions)

    }
    
    func registerUser() {
        service.register(email: user?.email ?? "", password: password)
            .sink { res in
                switch res {
                case let .failure(error):
                    break
                default: break
                }
            } receiveValue: { value in
                self.state = .successful
                self.isRegisterComplete = true
            }
            .store(in: &subscriptions)
        
    }

    func validatePassword() {
        var str = ""
        codeFields.forEach { code in
            str.append(code)
        }
        
        if str == user?.password {
            passwordValid = true
        } else {
            codeError.append(.passwordsDoesntMatch)
        }
    }
}
