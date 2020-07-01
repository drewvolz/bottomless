//
//  NoOrdersView.swift
//  Bottomless
//
//  Created by Drew Volz on 7/1/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import SwiftUI

struct NoOrders: View {
    @State var message: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(verbatim: message)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(1)
        }
    }
}

struct NoOrders_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                Section {
                    NoOrders(message: "No orders")
                }
            }
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
    }
}
