import SwiftUI

struct InProgressOrder: View {
    @State var order: InTransitionResponse

    var body: some View {
        VStack {
            HStack {
                RemoteImage(url: URL(string: self.order.subproductID.product.small_image_src)!)

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
            }
        }
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
