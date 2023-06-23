//
//  StepMenuViewModel.swift
//  Jumpeak
//
//  Created by Денис Большачков on 22/06/23.
//

import FirebaseStorage
import Combine


final class StepMenuViewModelImpl: ObservableObject {
    @Published var user: UnregistredUsers?
    @Published var userData: SelectedFirstDataUser?
    @Published var url: URL?
    
    @Published var countOfBaseInfo: Int = 0
    @Published var countOfVideoInfo: Int = 0
    @Published var countOfPortfolio: Int = 0
    
    @Published var hasVideo = false
    @Published var projects = [Project]()
    
    
    var projectService: ProjectService!
    
    //MARK: Private Properties
    private var subscriptions = Set<AnyCancellable>()

    func configure(with user: UnregistredUsers) {
        self.user = user
    }
    
    func configure(with userData: SelectedFirstDataUser) {
        self.userData = userData
        
        calculateBaseInfo()
        calculatePortfolio()
    }
    
    
    func getProjects() {
        guard let userId = userData?.userId else { return }
        
        projectService.getProjects(userId: userId)
            .sink { [weak self] res in
                switch res {
                case .failure(_): break
                default: break
                }
            } receiveValue: { projects in
                self.projects = projects
            }
            .store(in: &subscriptions)
    }

    private func calculateBaseInfo() {
        guard let userData = userData else { return }
        
        if userData.experiences.isEmpty == false {
            countOfBaseInfo += 1
        }
        if userData.selectedProffessions.isEmpty == false {
            countOfBaseInfo += 1
        }
        if userData.selectedSubject.isEmpty == false {
            countOfBaseInfo += 1
        }
        if userData.selectedHardSkills.isEmpty == false {
            countOfBaseInfo += 1
        }
        if userData.selectedSoftSkills.isEmpty == false {
            countOfBaseInfo += 1
        }
        if userData.photoPath?.isEmpty == false {
            countOfBaseInfo += 1
        }
    }
    
    private func calculatePortfolio() {
        guard let userData = userData else { return }
        
        countOfPortfolio = projects.count
    }
    
    func getURL() {
        guard let path = userData?.photoPath else { return }
        
            let storage = Storage.storage()
            storage.reference().child(path).downloadURL(completion: { url, error in
                guard let url = url else {
                    return
                }
                self.url = url
            })
        }
}
