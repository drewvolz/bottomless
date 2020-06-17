import SwiftUI

struct SearchRow: View {
    @ObservedObject var viewModel: SearchViewModel
    @State var product: ProductResponse

    var tags: [String]? {
        product.tags?.compactMap { tag in tag.name }
    }

    var body: some View {
        VStack {
            HStack {
                RemoteImage(url: URL(string: self.product.smallImageSrc ?? "")!)

                VStack(alignment: .leading) {
                    Text(verbatim: self.product.vendorName ?? "")
                        .font(.caption)
                        .bold()
                        .lineLimit(1)
                        .foregroundColor(Color.gray)

                    Text(verbatim: self.product.name ?? "")
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.vertical, 3)

                    HStack {
                        Text(verbatim: self.product.roast?.name ?? "")
                            .font(.caption)
                            .foregroundColor(Color.darkerRed)
                            .padding(5)
                            .overlay(Rectangle().stroke(Color.darkerRed, lineWidth: 1))

                        Text(verbatim: self.product.origin?.name ?? "")
                            .font(.caption)
                            .foregroundColor(Color.darkerRed)
                            .padding(5)
                            .overlay(Rectangle().stroke(Color.darkerRed, lineWidth: 1))
                    }
                }
            }
            .frame(height: 100)
        }
    }
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SearchRow(viewModel: SearchViewModel(), product: mockProducts.data.first!)
            }
        }
    }
}
