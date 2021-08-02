import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    @Published private(set) var loginResponse: LoginResponse? = nil

    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func login(authManager: AuthenticationManager) {
        guard !authManager.email.isEmpty, !authManager.password.isEmpty else {
            return
        }

        let parameterDictionary = [
            "email": authManager.email,
            "password": authManager.password,
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }

        fetchProvider.login(credentials: httpBody)
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                      self.loginResponse = $0.value?.onboardingState as LoginResponse?

                      if let _ = self.loginResponse?.accountCreated {
                          if authManager.createAccount() {
                              _ = authManager.authenticate()
                          }
                      }
                  })
            .store(in: &publishers)
    }
}
