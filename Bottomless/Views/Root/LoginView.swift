import Combine
import LocalAuthentication
import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var authManager: AuthenticationManager

    @State private var email = ""
    @State private var password = ""

    @ObservedObject var loginViewModel = LoginViewModel()

    @State private var showProfile = false
    @State private var showAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            Email()
            Password()
            Spacer()
            Submit()
            NavigationLink(destination: LoggedInTabsView(), isActive: $showProfile) {
                EmptyView()
            }
        }
        .padding()
        .navigationBarTitle("Log In")
        .environmentObject(authManager)
    }
}

// MARK: views

private extension LoginView {
    @ViewBuilder func Email() -> some View {
        SharedTextfield(
            value: $authManager.email,
            header: "Email",
            placeholder: "Your email",
            errorMessage: authManager.emailValidation.message
        )
    }

    @ViewBuilder func Password() -> some View {
        PasswordField(
            value: $authManager.password,
            header: "Password",
            placeholder: "Your password",
            errorMessage: authManager.passwordValidation.message,
            isSecure: true
        )
    }

    @ViewBuilder func Submit() -> some View {
        Button(action: login) {
            PrimaryButton(title: "Log In")
        }
        .disabled(!authManager.canLogin)
        .alert(isPresented: $showAlert) {
            if self.authManager.hasAccount() {
                return Alert(title: Text("Error"),
                             message: Text("Incorrect email or password."),
                             dismissButton: Alert.Button.default(Text("Ok")))
            }

            return Alert(title: Text("Error"),
                         message: Text("No account found."),
                         dismissButton: Alert.Button.default(Text("Ok")))
        }
    }
}

// MARK: functions

private extension LoginView {
    func login() {
        // showAlert = !authManager.authenticate()  // TODO: handle this

        loginViewModel.login(authManager: authManager)

        showProfile = authManager.isLoggedIn
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
