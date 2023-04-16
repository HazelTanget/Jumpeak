//
//  UIApplication+Extenstions.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
