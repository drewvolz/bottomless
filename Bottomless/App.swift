//
//  App.swift
//  Bottomless
//
//  Created by Drew Volz on 7/17/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import SwiftUI

@main
struct Bottomless: App {
    @StateObject private var store = Store()
    @StateObject private var authManager = AuthenticationManager()

    @SceneBuilder var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authManager)
                .environmentObject(store)
                .onAppear(perform: initialLaunch)
        }
    }

    private func initialLaunch() {
        if !UserDefaults.standard.bool(forKey: AuthKeys.initialLaunchKey) {
            authManager.deleteAccount()
            UserDefaults.standard.set(true, forKey: AuthKeys.initialLaunchKey)
        }
    }
}
