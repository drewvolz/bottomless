import SwiftUI

struct UpNextOrder: View {
    @State var order: UpNextResponse

    var body: some View {
        VStack {
            HStack {
                UrlImageView(urlString: self.order.product.small_image_src)

                VStack(alignment: .leading) {
                    Text(verbatim: self.order.product.vendor_name)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(Color.gray)

                    Text(verbatim: self.order.product.name)
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.vertical, 3)

                    Text("\(self.order.product.size)oz")
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}

struct UpNextOrder_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                UpNextOrder(order: mockUpNext)
            }
        }
    }
}
