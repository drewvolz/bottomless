//
//  ScaleView.swift
//  Bottomless
//
//  Created by Drew Volz on 7/1/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import SwiftUI

struct ScaleView: View {
    @ObservedObject var viewModel: ScaleViewModel

    var lastWeight: String {
        String(format: "%.2f", viewModel.scaleResponse?.scaleLastWeight ?? 0)
    }

    var power: String {
        let level = viewModel.scaleResponse?.scaleBatteryLevel ?? -1

        if level == -1 {
            return "..."
        }

        return String(format: "%.0f", floor(level * 100)) + "%"
    }

    var status: String {
        viewModel.scaleResponse?.id?.uppercaseFirst() ?? "Unknown"
    }

    var lastConnected: String {
        let last = viewModel.scaleResponse?.scaleLastConnected ?? ""
        return formatAsRelativeTime(string: last)
    }

    var body: some View {
        Group {
            HStack {
                Text("Last weight")
                Spacer()
                Text("\(lastWeight)oz")
            }

            HStack {
                Text("Battery level")
                Spacer()
                Text(power)
            }

            HStack {
                Text("Status")
                Spacer()
                Text(status)
            }

            HStack {
                Text("Last connected")
                Spacer()
                Text(lastConnected)
            }
        }
        .font(.body)
    }
}

struct ScaleView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleView(viewModel: ScaleViewModel())
    }
}
