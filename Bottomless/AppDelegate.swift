//
//  AppDelegate.swift
//  Bottomless
//
//  Created by Drew Volz on 4/18/21.
//  Copyright © 2021 Drew Volz. All rights reserved.
//

import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationDidFinishLaunching(_: UIApplication) {
        func resetState() {
            let defaultsName = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: defaultsName)
        }

        if CommandLine.arguments.contains(Keys.UITesting) {
//            Text disabling animation speedup
//            UIView.setAnimationsEnabled(false)
            resetState()
        }
    }
}
