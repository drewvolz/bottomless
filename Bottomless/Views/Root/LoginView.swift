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
            SharedTextfield(
                value: self.$authManager.email,
                header: "Email",
                placeholder: "Your email",
                errorMessage: authManager.emailValidation.message
            )

            PasswordField(
                value: self.$authManager.password,
                header: "Password",
                placeholder: "Your password",
                errorMessage: authManager.passwordValidation.message,
                isSecure: true
            )

            Spacer()

            Button(action: login) {
                PrimaryButton(title: "Log In")
            }
            .disabled(!self.authManager.canLogin)
            .alert(isPresented: self.$showAlert) {
                if self.authManager.hasAccount() {
                    return Alert(title: Text("Error"),
                                 message: Text("Incorrect email or password."),
                                 dismissButton: Alert.Button.default(Text("Ok")))
                }

                return Alert(title: Text("Error"),
                             message: Text("No account found."),
                             dismissButton: Alert.Button.default(Text("Ok")))
            }

            NavigationLink(destination: LoggedInTabsView(), isActive: $showProfile) {
                EmptyView()
            }
        }
        .padding()
        .navigationBarTitle("Log In")
        .environmentObject(authManager)
    }

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
