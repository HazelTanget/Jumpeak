//
//  SecondStepViewModel.swift
//  Jumpeak
//
//  Created by Денис Большачков on 11/06/23.
//

import Foundation
import SwiftUI


class SecondStepViewModel: ObservableObject {
    @Published var selection = 0
    @Published var navigationPath = NavigationPath()
    
    @Published var projectName = ""
    @Published var projectDescription = ""
    
    @Published var shouldShowMenu = false
    
    // link git
    @Published var gitHubLink = ""
    @Published var shouldPresentGitHubSheet = false
    
}
