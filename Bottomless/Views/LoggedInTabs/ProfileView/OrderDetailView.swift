//
//  OrderDetailView.swift
//  Bottomless
//
//  Created by Drew Volz on 10/25/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import SwiftUI

struct OrderDetailView: View {
    var order: OrdersResponse

    typealias TrackingItems = [OrdersResponse.TrackingDetail]
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
            formatStringAsShortDateString(dateString: $0.datetime)
        }).sorted { group1, group2 -> Bool in
            group1.key.compare(group2.key) == .orderedDescending
        }
    }

    var body: some View {
        List {
            PastOrder(order: order, shouldLink: false)
            Tracking()
        }
        .groupedStyle()
    }
}

private extension OrderDetailView {
    @ViewBuilder func Tracking() -> some View {
        ForEach(groupedItems ?? [], id: \.key) { day in
            Section(header: Text(formatAsReadableDateString(dateString: day.key))) {
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

                        if let city = item.trackingLocation?.city,
                           let state = item.trackingLocation?.state
                        {
                            Text("\(city), \(state)")
                                .font(.caption)
                        }
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

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(order: mockOrders)
    }
}
