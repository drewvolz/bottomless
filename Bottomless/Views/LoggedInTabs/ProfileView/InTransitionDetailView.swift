//
//  InTransitionDetailView.swift
//  Bottomless
//
//  Created by Drew Volz on 11/5/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import SwiftUI

struct InTransitionDetailView: View {
    var order: InTransitionResponse

    typealias TrackingItems = [InTransitionResponse.TrackingDetail]
    typealias GroupedTracking = [(key: String, value: TrackingItems)]

    var trackingDetails: TrackingItems? {
        order.trackingUpdates?.map { update in
            update.trackingDetails ?? []
        }.last
    }

    var groupedItems: GroupedTracking? {
        groupItems(items: trackingDetails ?? [])
    }

    private func groupItems(items: TrackingItems) -> GroupedTracking {
        Dictionary(grouping: items, by: {
            formatAsLongDate(dateString: $0.datetime)
        }).sorted { (group1, group2) -> Bool in
            group1.key.compare(group2.key) == .orderedDescending
        }
    }

    var body: some View {
        List {
            InProgressOrder(order: order, shouldLink: false)
            Tracking()
        }
        .groupedStyle()
    }
}

private extension InTransitionDetailView {
    @ViewBuilder func Tracking() -> some View {
        ForEach(groupedItems ?? [], id: \.key) { day in
            Section(header: Text(day.key)) {
                ForEach(day.value.reversed(), id: \.self) { item in
                    HStack {
                        HStack {
                            Text(formatAsTime(string: item.datetime))
                                .font(.caption)
                                .frame(width: 60)

                            Text(item.message)
                                .font(.caption)
                        }
                        Spacer()
                        Text("\(item.trackingLocation?.city ?? ""), \(item.trackingLocation?.state ?? "")")
                            .font(.caption)
                    }
                }
            }
        }

        if let url = order.trackingUpdates?.first?.publicUrl {
            Link("Open in browser…", destination: URL(string: url)!)
                .font(.caption)
        }
    }
}

struct InTransitionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InTransitionDetailView(order: mockInTransition)
    }
}
