import SwiftUI

struct InProgressOrder: View {
    @State var order: InTransitionResponse

    var body: some View {
        VStack {
            HStack {
                UrlImageView(urlString: self.order.subproductID.product.small_image_src)

                VStack(alignment: .leading) {
                    Text(verbatim: self.order.subproductID.product.vendor_name)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(Color.gray)

                    Text(verbatim: self.order.subproductID.product.name)
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.vertical, 3)

                    Text(verbatim: self.order.grind.name)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(Color.gray)
                }

                Spacer()

                Text(statusName(order: order))
                    .font(.caption)
                    .bold()
                    .padding(3)
                    .lineLimit(1)
                    .foregroundColor(Color.darkerRed)
                    .overlay(
                        Rectangle()
                            .stroke(Color.darkerRed, lineWidth: 1))
            }
        }
    }
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

struct InProgressOrder_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                InProgressOrder(order: mockInTransition)
            }
        }
    }
}
