//
//  Binding+Extensions.swift
//  Jumpeak
//
//  Created by Денис Большачков on 03.06.2023.
//

import SwiftUI

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
