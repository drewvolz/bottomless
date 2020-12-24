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

    @ObservedObject var viewModel: OrdersViewModel

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
            PastOrder(order: order, shouldLink: false, viewModel: viewModel)

            HStack(alignment: .center, spacing: 10, content: {
                Spacer()
                LikeButton()
                Spacer()
                DislikeButton()
                Spacer()
            })

            Tracking()
        }
        .groupedStyle()
    }
}

private extension OrderDetailView {
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

    func LikeButton() -> some View {
        func likeToggled() {}

        return ToggleFeedbackButton(symbol: "hand.thumbsup",
                                    tappedText: "Liked",
                                    untappedText: "Like",
                                    feedbackType: .Like,
                                    pressed: order.productFeedback?.like ?? false,
                                    order: order,
                                    callback: likeToggled,
                                    viewModel: viewModel)
    }

    func DislikeButton() -> some View {
        func dislikeToggled() {}

        return ToggleFeedbackButton(symbol: "hand.thumbsdown",
                                    tappedText: "Disliked",
                                    untappedText: "Dislike",
                                    feedbackType: .Dislike,
                                    pressed: order.productFeedback?.dislike ?? false,
                                    order: order,
                                    callback: dislikeToggled,
                                    viewModel: viewModel)
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(order: mockOrders, viewModel: OrdersViewModel())
    }
}
