//
//  NothingSelectedView.swift
//  Bottomless
//
//  Created by Matthaus Woolard on 2/13/21.
//  Modified by Drew Volz on 2/16/21
//  https://lostmoa.com/blog/SummoningSplitViewSidebar
//  Copyright © 2021 Drew Volz. All rights reserved.
//

import SwiftUI

struct NothingSelectedView: View {
    #if canImport(UIKit)
        @State var onScreen: Bool = false
    #endif

    var body: some View {
        Label("Nothing Selected", systemImage: "sparkles")

        #if canImport(UIKit)
            UIKitShowSidebar(onScreen: onScreen)
                .frame(width: 0, height: 0)
                .onAppear {
                    onScreen = true
                }.onDisappear {
                    onScreen = false
                }
        #endif
    }
}

struct NothingSelectedView_Previews: PreviewProvider {
    static var previews: some View {
        NothingSelectedView()
    }
}
