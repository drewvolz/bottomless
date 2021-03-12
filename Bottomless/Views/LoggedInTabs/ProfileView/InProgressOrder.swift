import SwiftUI

struct InProgressOrder: View {
    @State var order: InTransitionResponse
    @State var shouldLink = true

    var body: some View {
        if shouldLink {
            NavigationLink(destination: InTransitionDetailView(order: order)) {
                InProgressOrderRow()
            }
        } else {
            InProgressOrderRow()
            EstimatedDelivery()
        }
    }
}

// MARK: views

private extension InProgressOrder {
    func InProgressOrderRow() -> some View {
        VStack {
            HStack {
                UrlImageView(urlString: self.order.subproductID?.product.small_image_src)

                VStack(alignment: .leading, spacing: 0) {
                    Text(verbatim: self.order.subproductID?.product.vendor_name ?? "")
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(Color.gray)

                    Text(verbatim: self.order.subproductID?.product.name ?? "")
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.vertical, 3)

                    Text("\(self.order.grind.name)")
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(Color.gray)

                    if shouldLink {
                        EstimatedDelivery()
                    }
                }
            }
        }
    }

    @ViewBuilder func EstimatedDelivery() -> some View {
        if let deliveryDate = order.trackingUpdates?.first?.estimatedDeliveryDate {
            HStack(spacing: 3) {
                Text("Estimated to arrive")
                Text(formatAsRelativeTime(string: deliveryDate, fromFormatter: .utc))
                    .bold()
            }
            .font(.caption)
            .foregroundColor(Color.gray)
        }
    }
}

// MARK: functions

private extension InProgressOrder {
    private func parseProduct(order: InTransitionResponse) -> InTransitionResponse.Product {
        var parsedProduct = InTransitionResponse.Product(_id: "", name: "", vendor_name: "", small_image_src: "")

        if order.subproductID != nil {
            parsedProduct = order.subproductID!.product
        } else if order.productID != nil {
            parsedProduct = order.productID!.product
        }

        return parsedProduct
    }

    private func statusName(order: InTransitionResponse) -> String {
        let availableStatuses = [
            "Scheduled": "scheduled",
            "Roasting": "roasting",
            "InTransit": "in_transit",
            "OutOfDelivery": "out_for_delivery",
            "Delivered": "delivered",
        ]

        if let val = availableStatuses[order.shippingStatus?.rawValue ?? ""] {
            return val
        }

        if (order.status == "sent_to_roaster") || order.status == "fulfilled" && order.trackingNumber?.count ?? 0 < 1 {
            return "Roasting"
        }

        if order.status == "fulfilled", order.trackingNumber?.count ?? 0 > 0 {
            return "In Transit"
        }

        return "Scheduled"
    }
}

struct InProgressOrder_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                InProgressOrder(order: mockInTransition)
            }
        }
    }
}
