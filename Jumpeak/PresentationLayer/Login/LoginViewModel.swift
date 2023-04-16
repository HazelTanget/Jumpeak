//
//  LoginViewModel.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import Combine

enum DefaultState {
    case na
    case failed(error: Error)
    case successful
}

final class LoginViewModel: ObservableObject {
    var authService: FirebaseAuthService!
    @Published var state = DefaultState.na
    @Published var credentials = LoginCredentials.new
    @Published var hasErrors: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    func login() {
        authService.login(with: credentials)
            .sink { res in
                switch res {
                case let .failure(error):
                    self.state = .failed(error: error)
                    self.hasErrors = true
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successful
            }
            .store(in: &subscriptions)
    }
}
