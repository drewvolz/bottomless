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
            formatAsLongDate(dateString: $0.datetime)
        }).sorted { (group1, group2) -> Bool in
            group1.key.compare(group2.key) == .orderedDescending
        }
    }

    var body: some View {
        List {
            ImageAndProductInfo()
            Tracking()
        }
        .groupedStyle()
    }
}

private extension OrderDetailView {
    @ViewBuilder func ImageAndProductInfo() -> some View {
        Section {
            HStack {
                UrlImageView(urlString: order.subproductID.product.small_image_src)

                VStack(alignment: .leading) {
                    Text(verbatim: order.subproductID.product.name)
                        .font(.title)
                        .bold()

                    Text(verbatim: order.subproductID.product.vendor_name)
                        .font(.subheadline)
                }
            }.padding(.vertical, 12)
        }
    }

    @ViewBuilder func Tracking() -> some View {
        ForEach(groupedItems ?? [], id: \.key) { day in
            Section(header: Text(day.key)) {
                ForEach(day.value.reversed(), id: \.self) { item in
                    HStack {
                        HStack {
                            Text(formatAsTime(string: item.datetime))
                                .font(.caption)
                                .frame(width: 40)

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

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(order: mockOrders)
    }
}