import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    @Published private(set) var loginResponse: LoginResponse? = nil

    private var loginCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        loginCancellable?.cancel()
    }

    func login(authManager: AuthenticationManager) {
        guard !authManager.email.isEmpty, !authManager.password.isEmpty else {
            return
        }

        let url = URL(string: Urls.api.auth)!

        let parameterDictionary = [
            "email": authManager.email,
            "password": authManager.password,
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = httpBody

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        /*
         * TODO: This casuses an error. Please switch to the publisher chain below instead.
         *
         * Publishing changes from background threads is not allowed; make sure to
         * publish values from the main thread (via operators like receive(on:)) on model updates.
         *
         */
        loginCancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    print(error)
                case .finished:
                    print("Success")
                }
            },
            receiveValue: { value in
                let decoder = JSONDecoder()

                do {
                    let loginResponse = try decoder.decode(LoginResultResponse.self, from: value.data)
                    self.loginResponse = loginResponse.onboardingState

                    if loginResponse.onboardingState.accountCreated {
                        if authManager.createAccount() {
                            _ = authManager.authenticate()
                        }
                    }
                } catch {
                    print(error)

                    do {
                        let errorLoginResponse = try decoder.decode(ErrorLoginResultResponse.self, from: value.data)
                        print(errorLoginResponse)
                    } catch {
                        print(error)
                    }
                }
            }
        )

        /*
         * Todo: This is the right way to do it, but I'm not sure how to work
         * in the authManager chain of events that are in the receiveValue's "do block" yet
         */
//        loginCancellable = publisher
//            .map { $0.data }
//            .decode(type: LoginResultResponse.self, decoder: JSONDecoder())
//            .map { $0.onboardingState }
//            .replaceError(with: nil)
//            .receive(on: RunLoop.main)
//            .assign(to: \.loginResponse, on: self)
    }
}
