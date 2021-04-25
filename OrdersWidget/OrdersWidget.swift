//
//  OrdersWidget.swift
//  OrdersWidget
//
//  Created by Drew Volz on 4/25/21.
//  Copyright © 2021 Drew Volz. All rights reserved.
//

import Foundation
import SwiftUI
import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let product: UpNextResponse.Product
}

struct Provider: TimelineProvider {
    func placeholder(in _: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), product: mockWidgetProduct)
    }

    func getSnapshot(in _: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), product: mockWidgetProduct)
        completion(entry)
    }

    func readUpNextOrder() -> UpNextResponse.Product {
        do {
            let encodedData = UserDefaults(suiteName: Keys.SharedGroupID)!.value(forKey: Keys.UpNextOrder) as? String
            if let stringAsData = encodedData {
                let data = stringAsData.data(using: String.Encoding.utf8)!
                let product = try JSONDecoder().decode(UpNextResponse.self, from: data).product
                return product
            }
        } catch {
            print("Error in parsing \(Keys.SharedGroupID) in the widget: \(error.localizedDescription)")
        }

        return mockWidgetProduct
    }

    func getTimeline(in _: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let product = readUpNextOrder()

        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, product: product)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct OrdersWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        UpNextOrder(order: UpNextResponse(id: "", product: entry.product))
            .padding()
    }
}

@main
struct OrdersWidget: Widget {
    let kind: String = Keys.OrdersWidgetID

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            OrdersWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .configurationDisplayName("Upcoming Orders")
        .description("View the status of your upcoming orders.")
    }
}

struct OrdersWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrdersWidgetEntryView(entry: SimpleEntry(date: Date(), product: mockWidgetProduct))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}

let mockWidgetProduct = UpNextResponse.Product(_id: "123", origin: "5bced923ae8c5c6b0faae148", size: 12, vendor_id: "5a32e6796bd23b00147e33bd", vendor_name: "Olympia Coffee Roasting Co.", description: "Olympia Coffee Roasting Co. specializes in sourcing single origin coffees, and making them available seasonally. We'll rotate you through a selection of what they have available", name: "Mock Rotation", small_image_src: "https://bottomless.imgix.net/products/Olympia/generic-nobg.png?auto=compress&w=300", status: "active", roast: "5bced984ae8c5c6b0faae149")
