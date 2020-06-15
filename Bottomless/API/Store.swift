import SwiftUI

class Store: ObservableObject {
    struct AppState {
        var loginResponse: LoginResponse?
    }

    @Published private(set) var state = AppState(loginResponse: nil)
}
