import SwiftUI

struct RootView: View {
    @EnvironmentObject private var authManager: AuthenticationManager

    var body: some View {
        NavigationView {
            if authManager.hasAccount() {
                LoggedInTabsView()
            } else {
                WelcomeView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                RootView()
            }
        }
    }
}
