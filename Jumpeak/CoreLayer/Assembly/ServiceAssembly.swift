//
//  ServiceAssembly.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import Swinject

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FirebaseAuthService.self) { r in
            FirebaseAuthServiceImpl()
        }
        .inObjectScope(.transient)

        container.register(SessionService.self) { r in
            SessionService()
        }
        .inObjectScope(.transient)
        
        container.register(HardSkillsService.self) { r in
            HardSkillsServiceImpl()
        }
        .inObjectScope(.transient)
        
        container.register(ProfessionsService.self) { r in
            ProfessionsServiceImpl()
        }
        .inObjectScope(.transient)
        
        container.register(SubjectService.self) { r in
            SubjectServiceImpl()
        }
        .inObjectScope(.transient)
        
        container.register(SoftSkillsService.self) { r in
            SoftSkillsServiceImpl()
        }
        .inObjectScope(.transient)
    }
}
