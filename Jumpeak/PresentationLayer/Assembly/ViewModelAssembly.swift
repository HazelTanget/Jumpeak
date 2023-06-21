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
        .inObjectScope(.container)

        container.register(RegistrationViewModel.self) { r in
            let viewModel = RegistrationViewModel()
            viewModel.service = r.resolve(FirebaseAuthService.self)
            viewModel.impactService = r.resolve(ImpactService.self)
            
            return viewModel
        }
        .inObjectScope(.container)

        container.register(FirstStepViewModel.self) { r in
            let viewModel = FirstStepViewModel()
            viewModel.hardSkillsService = r.resolve(HardSkillsService.self)
            viewModel.softSkillsService = r.resolve(SoftSkillsService.self)
            viewModel.professionsService = r.resolve(ProfessionsService.self)
            viewModel.subjectService = r.resolve(SubjectService.self)
            viewModel.impactService = r.resolve(ImpactService.self)

            return viewModel
        }
        .inObjectScope(.container)
        
        container.register(ExperienceViewModel.self) { r in
            let viewModel = ExperienceViewModel()

            return viewModel
        }
        .inObjectScope(.transient)
        
        container.register(SecondStepViewModel.self) { r in
            let viewModel = SecondStepViewModel()
            viewModel.projectService = r.resolve(ProjectService.self)

            return viewModel
        }
        .inObjectScope(.container)
    }
}
