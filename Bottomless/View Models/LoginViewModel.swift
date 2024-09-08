import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    @Published private(set) var loginResponse: LoginResponse? = nil

    var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func login(authManager: AuthenticationManager) -> AnyPublisher<Bool, LoginError> {
        guard !authManager.email.isEmpty, !authManager.password.isEmpty else {
            return Fail(error: LoginError.emptyFields).eraseToAnyPublisher()
        }

        let parameterDictionary = [
            "email": authManager.email,
            "password": authManager.password,
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return Fail(error: LoginError.serializationError).eraseToAnyPublisher()
        }

        return fetchProvider.login(credentials: httpBody)
            .map { response in
                self.loginResponse = response.value?.onboardingState as LoginResponse?
                if let accountCreated = self.loginResponse?.accountCreated, accountCreated {
                    if authManager.createAccount() {
                        _ = authManager.authenticate()
                    }
                }
                return true
            }
            .mapError { error in
                return LoginError.networkError(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
