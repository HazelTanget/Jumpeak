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
    @Published var shouldShowProjectList: Bool = false
    
    @Published var userId: String?
    
    @Published var editProject = Project()
    
    // link git
    @Published var gitHubLink = ""
    @Published var shouldPresentGitHubSheet = false
    
    var projectService: ProjectService!

    @Published var projects = [Project]()
    
    
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
        shouldShowProjectList = true
    }

    func checkGitHubLink() -> Bool {
        let range = NSRange(location: 0, length: gitHubLink.utf16.count)
        let regex = try! NSRegularExpression(pattern: "^https:\\/\\/github\\.com(?:\\/[^\\s\\/]+){2}$")
        return regex.firstMatch(in: gitHubLink, options: [], range: range) != nil
    }
    
    func getProjects() {
        guard let userId = self.userId else { return }
        
        projectService.getProjects(userId: userId)
            .sink { [weak self] res in
                switch res {
                case .failure(_):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { projects in
                self.projects = projects
            }
            .store(in: &subscriptions)
    }
    
    func uploadProject() {
        editProject.userId = userId
        projectService.uploadProject(project: editProject)
            .sink { [weak self] res in
                switch res {
                case .failure(_):
                    self?.hasErrors = true
                default: break
                }
            } receiveValue: { skill in
                self.shouldShowProjectList = true
            }
            .store(in: &subscriptions)
    }
}
