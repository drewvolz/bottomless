import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let store = Store()
    let authManager = AuthenticationManager()

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if !UserDefaults.standard.bool(forKey: AuthKeys.initialLaunchKey) {
            authManager.deleteAccount()
            UserDefaults.standard.set(true, forKey: AuthKeys.initialLaunchKey)
        }

        let contentView = RootView()
            .environmentObject(authManager)
            .environmentObject(store)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)

            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneWillResignActive(_: UIScene) {
//        authManager.logout()
    }

    func sceneDidEnterBackground(_: UIScene) {
//        authManager.logout()
    }
}
