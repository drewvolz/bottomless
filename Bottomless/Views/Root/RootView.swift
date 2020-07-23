import SwiftUI

struct RootView: View {
    @EnvironmentObject private var authManager: AuthenticationManager

    var body: some View {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return AnyView(
                NavigationView {
                    iPhoneView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
            )
        case .pad:
            return AnyView(
                NavigationView {
                    iPadView()
                }
            )
        default:
            return AnyView(EmptyView())
        }
    }

    private func iPhoneView() -> AnyView {
        if authManager.hasAccount() {
            return AnyView(LoggedInTabsView())
        } else {
            return AnyView(WelcomeView())
        }
    }

    private func iPadView() -> AnyView {
        if authManager.hasAccount() {
            return AnyView(Group {
                LoggedInSidebarView(selectedId: 0)
                EmptyView()
            })
        } else {
            return AnyView(WelcomeView())
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
