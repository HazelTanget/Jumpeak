//
//  ViewModelAssembly.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LoginViewModel.self) { r in
            let viewModel = LoginViewModel()
            viewModel.authService = r.resolve(FirebaseAuthService.self)
            
            return viewModel
        }
        .inObjectScope(.transient)

        container.register(RegistrationViewModel.self) { r in
            let viewModel = RegistrationViewModel()
            viewModel.service = r.resolve(FirebaseAuthService.self)
            
            return viewModel
        }
        .inObjectScope(.transient)
    }
}
