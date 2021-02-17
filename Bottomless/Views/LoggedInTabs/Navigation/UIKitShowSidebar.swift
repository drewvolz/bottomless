//
//  UIKitShowSidebar.swift
//  Bottomless
//
//  Created by Matthaus Woolard on 2/13/21.
//  Modified by Drew Volz on 2/16/21
//  https://lostmoa.com/blog/SummoningSplitViewSidebar
//  Copyright © 2021 Drew Volz. All rights reserved.
//

import SwiftUI

struct UIKitShowSidebar: UIViewRepresentable {
    let onScreen: Bool

    func makeUIView(context _: Context) -> some UIView {
        let uiView = UIView()

        if onScreen {
            DispatchQueue.main.async { [weak uiView] in
                uiView?.next(
                    of: UISplitViewController.self
                )?.show(.primary)
            }
        }

        return uiView
    }

    func updateUIView(_ uiView: UIViewType, context _: Context) {
        DispatchQueue.main.async { [weak uiView] in
            uiView?.next(
                of: UISplitViewController.self
            )?.show(.primary)
        }
    }
}

extension UIResponder {
    func next<T>(of type: T.Type) -> T? {
        guard let nextValue = self.next else {
            return nil
        }
        guard let result = nextValue as? T else {
            return nextValue.next(of: type.self)
        }
        return result
    }
}
