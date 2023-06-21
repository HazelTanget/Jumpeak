//
//  ImpactService.swift
//  Jumpeak
//
//  Created by Денис Большачков on 21/06/23.
//

import UIKit

protocol ImpactService {
    func callLightImpact()
    func callMediumImpact()
    func callHardImpact()
}

final class ImpactServiceImpl: ImpactService {
    func callLightImpact() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func callMediumImpact() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func callHardImpact() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
}
