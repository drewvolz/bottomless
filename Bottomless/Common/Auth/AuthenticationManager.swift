// File: AuthenticationManager.swift
// Project: SinglePass

// Created at 23/02/2020 by Liquidcoder
// Visit https://www.liquidcoder.com for more
// Copyright © Liquidcoder. All rights reserved

import Combine
import CryptoKit
import KeychainSwift
import LocalAuthentication
import SwiftUI

class AuthenticationManager: ObservableObject {
    var cancellableSet: Set<AnyCancellable> = []

    @Published var email = ""
    @Published var password = ""

    @Published var canLogin = false

    @Published var emailValidation = FormValidation()
    @Published var passwordValidation = FormValidation()

    private var userDefaults = UserDefaults.standard
    private var laContext = LAContext()

    @Published var isLoggedIn = false
    @Published var userAccount = User()

    private var keychain = KeychainSwift()

    @Published var biometryType = LABiometryType.none

    private var emailPublisher: AnyPublisher<FormValidation, Never> {
        $email.debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { email in

                if email.isEmpty {
                    return FormValidation(success: false, message: "")
                }

                return FormValidation(success: true, message: "")
            }
            .eraseToAnyPublisher()
    }

    private var passwordPublisher: AnyPublisher<FormValidation, Never> {
        $password.debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in

                if password.isEmpty {
                    return FormValidation(success: false, message: "")
                }

                return FormValidation(success: true, message: "")
            }
            .eraseToAnyPublisher()
    }

    init() {
        emailPublisher
            .assign(to: \.emailValidation, on: self)
            .store(in: &cancellableSet)

        passwordPublisher
            .assign(to: \.passwordValidation, on: self)
            .store(in: &cancellableSet)

        Publishers.CombineLatest(emailPublisher, passwordPublisher)
            .map {
                emailValidation, passwordValidation in
                emailValidation.success && passwordValidation.success
            }
            .assign(to: \.canLogin, on: self)
            .store(in: &cancellableSet)
    }

    func hasAccount() -> Bool {
        guard let _ = keychain.get(AuthKeys.email) else { return false }
        return true
    }

    func createAccount() -> Bool {
        // Removing this check since we always want to create a new account...
//        guard !hasAccount() else { return false }

        let hashedPassword = hashPassword(password)

        let emailResult = keychain.set(email.lowercased(),
                                       forKey: AuthKeys.email,
                                       withAccess: .accessibleWhenPasscodeSetThisDeviceOnly)

        let passwordResult = keychain.set(hashedPassword,
                                          forKey: AuthKeys.password,
                                          withAccess: .accessibleWhenPasscodeSetThisDeviceOnly)

        if emailResult, passwordResult {
            login()
            return true
        }

        return false
    }

    private func login() {
        userDefaults.set(true, forKey: AuthKeys.isLoggedIn)
        isLoggedIn = true
    }

    private func hashPassword(_ password: String, reset: Bool = false) -> String {
        var salt = ""

        if let savedSalt = keychain.get(AuthKeys.salt), !reset {
            salt = savedSalt
        } else {
            let key = SymmetricKey(size: .bits256)
            salt = key.withUnsafeBytes { Data(Array($0)).base64EncodedString() }
            keychain.set(salt, forKey: AuthKeys.salt)
        }

        guard let data = "\(password)\(salt)".data(using: .utf8) else { return "" }

        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }

    func authenticate() -> Bool {
        if !hasAccount() {
            return false
        }

        if let savedEmail = keychain.get(AuthKeys.email),
            let savedPassword = keychain.get(AuthKeys.password) {
            let hashedPassword = hashPassword(password)

            if savedEmail == email.lowercased(), hashedPassword == savedPassword {
                login()
                return true
            }
        }

        return false
    }

    func logout() {
        userDefaults.set(false, forKey: AuthKeys.isLoggedIn)
        isLoggedIn = false
    }

    func deleteAccount() {
        keychain.delete(AuthKeys.email)
        keychain.delete(AuthKeys.password)
        keychain.delete(AuthKeys.salt)
        logout()
    }

    func canAuthenticate(error: NSErrorPointer) -> Bool {
        laContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: error)
    }
}
