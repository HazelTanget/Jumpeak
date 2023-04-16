//
//  LoginCredentials.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

struct LoginCredentials {
    var email: String
    var password: String
}

extension LoginCredentials {
    static var new = LoginCredentials(email: "", password: "")
}
