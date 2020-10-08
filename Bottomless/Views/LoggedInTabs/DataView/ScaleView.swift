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

    var power: String {
        let level = viewModel.scaleResponse?.scaleBatteryLevel ?? -1

        if level == -1 {
            return "..."
        }

        return String(round(level * 100)) + "%"
    }
    var body: some View {
        Group {
            HStack {
                Text("Last weight")
                Spacer()
                Text("\(String(format: "%.2f", viewModel.scaleResponse?.scale_last_weight ?? 0))oz")

            HStack {
                Text("Battery level")
                Spacer()
                Text(power)
            }

            HStack {
                Text("Status")
                Spacer()
                Text("\(viewModel.scaleResponse?.id?.uppercaseFirst() ?? "Unknown")")
            }

            HStack {
                Text("Last connected")
                Spacer()
                Text("\(formatAsRelativeTime(string: viewModel.scaleResponse?.scale_last_connected ?? ""))")
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
