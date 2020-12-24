import SwiftUI

struct PastOrder: View {
    @State var order: OrdersResponse
    @State var shouldLink = true

    @ObservedObject var viewModel: OrdersViewModel

    var body: some View {
        if shouldLink {
            NavigationLink(destination: OrderDetailView(order: order, viewModel: viewModel)) {
                PastOrderRow()
            }
        } else {
            PastOrderRow()
        }
    }
}

private extension PastOrder {
    func PastOrderRow() -> some View {
        VStack {
            HStack {
                UrlImageView(urlString: self.order.subproductID.product.small_image_src)

                VStack(alignment: .leading, spacing: 0) {
                    Text(verbatim: self.order.subproductID.product.vendor_name)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(Color.gray)

                    Text(verbatim: self.order.subproductID.product.name)
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.vertical, 3)

                    Text("\(self.order.grind.name)")
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}

struct PastOrder_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                PastOrder(order: mockOrders, viewModel: OrdersViewModel())
            }
        }
    }
}
