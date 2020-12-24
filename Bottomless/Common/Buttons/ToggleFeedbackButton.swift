//
//  ToggleFeedbackButton.swift
//  Bottomless
//
//  Created by Drew Volz on 12/23/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import SwiftUI

struct ToggleFeedbackButton: View {
    let symbol: String
    let tappedText: String
    let untappedText: String
    let feedbackType: OrdersViewModel.FeedbackType

    @State var pressed: Bool
    @State var order: OrdersResponse
    let callback: () -> Void

    @ObservedObject var viewModel: OrdersViewModel

    @State var activeSymbol = ""
    @State var activeText = ""

    var body: some View {
        Button(action: {}) {
            VStack {
                Image(systemName: activeSymbol)
                    .foregroundColor(.accentColor)
                Text(activeText)
                    .font(.callout)
            }
        }
        .onTapGesture {
            pressed.toggle()
            viewModel.post(orderId: order.id, feedback: feedbackType, value: pressed)
            callback()

            if pressed {
                activeSymbol = "\(symbol).fill"
                activeText = tappedText
            } else {
                activeSymbol = symbol
                activeText = untappedText
            }
        }
        .onAppear {
            activeSymbol = pressed ? "\(symbol).fill" : symbol
            activeText = pressed ? tappedText : untappedText
        }
    }
}
