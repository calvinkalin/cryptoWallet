//
//  LoginViewModel.swift
//  CryptoWallet
//
//  Created by Ilya Kalin on 11.03.2025.
//

import Foundation

class LoginViewModel {
    private let correctUsername = "1234"
    private let correctPassword = "1234"
    
    func validateCredentials(username: String, password: String) -> Bool {
        return username == correctUsername && password == correctPassword
    }
    
    func login() {
        UserDefaults.standard.set(true, forKey: "isAuthenticated")
    }
}
