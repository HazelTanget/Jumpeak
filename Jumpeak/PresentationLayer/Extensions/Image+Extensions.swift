//
//  Image+Extensions.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import SwiftUI

extension Image {
    func iconModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
    }
}
