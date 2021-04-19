import SwiftUI

struct RootView: View {
    @EnvironmentObject private var authManager: AuthenticationManager

    var body: some View {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            iPhoneNavigation()
        case .pad:
            iPadNavigation()
        default:
            EmptyView()
        }
    }
}

// MARK: iPhone navigation

private extension RootView {
    @ViewBuilder func iPhoneNavigation() -> some View {
        NavigationView {
            iPhoneView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    @ViewBuilder func iPhoneView() -> some View {
        if authManager.hasAccount() || CommandLine.arguments.contains(Keys.UITesting) {
            LoggedInTabsView()
        } else {
            WelcomeView()
        }
    }
}

// MARK: iPad navigation

private extension RootView {
    @ViewBuilder func iPadNavigation() -> some View {
        NavigationView {
            iPadView()
            NothingSelectedView()
        }.navigationViewStyle(
            DoubleColumnNavigationViewStyle()
        )
    }

    @ViewBuilder func iPadView() -> some View {
        if authManager.hasAccount() {
            Group {
                LoggedInSidebarView()
                EmptyView()
            }
        } else {
            WelcomeView()
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
