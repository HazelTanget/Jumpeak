//
//  SecondStepViewModel.swift
//  Jumpeak
//
//  Created by Денис Большачков on 11/06/23.
//

import Foundation
import SwiftUI
import Combine


class SecondStepViewModel: ObservableObject {
    @Published var selection = 0
    @Published var navigationPath = NavigationPath()
    @Published var prjListNavigationPath = NavigationPath()
    
    @Published var shouldShowMenu = false
    @Published var hasErrors: Bool = false
    
    @Published var editProject = Project()
    
    // link git
    @Published var gitHubLink = ""
    @Published var shouldPresentGitHubSheet = false
    
    var projectService: ProjectService!
    
    
    //MARK: Private Properties
    private var subscriptions = Set<AnyCancellable>()
    
    func saveLink() {
        guard checkGitHubLink() else {
            hasErrors = true
            return 
        }

        editProject.gitHubLink = gitHubLink
    }
    
    func didTapLinkButton() {
        guard let url = URL(string: editProject.gitHubLink ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    func didTapNextButton() {
        navigationPath.append(Views.projectList)
    }

    func checkGitHubLink() -> Bool {
        let range = NSRange(location: 0, length: gitHubLink.utf16.count)
        let regex = try! NSRegularExpression(pattern: "^https:\\/\\/github\\.com(?:\\/[^\\s\\/]+){2}$")
        return regex.firstMatch(in: gitHubLink, options: [], range: range) != nil
    }
    
    func getProjects() {
        projectService.getProjects()
            .sink { [weak self] res in
                switch res {
                case .failure(_):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { softSkills in
                
            }
            .store(in: &subscriptions)
    }
}
