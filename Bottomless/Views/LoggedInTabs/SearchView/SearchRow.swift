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
                UrlImageView(urlString: self.product.smallImageSrc)

                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 0) {
                        Vendor()
                        Product()
                    }

                    HStack {
                        Roast()
                        Origin()

                        if product.likes > 0 {
                            Likes()
                        }
                    }
                }
            }
            .frame(height: 100)
        }
    }
}

private extension SearchRow {
    @ViewBuilder func Vendor() -> some View {
        Text(verbatim: product.vendorName ?? "")
            .font(.caption)
            .bold()
            .lineLimit(1)
            .foregroundColor(Color.gray)
    }

    @ViewBuilder func Product() -> some View {
        Text(verbatim: product.name ?? "")
            .font(.headline)
            .lineLimit(1)
            .padding(.vertical, 3)
    }

    @ViewBuilder func Roast() -> some View {
        Text(verbatim: product.roast?.name ?? "")
            .font(.caption)
            .foregroundColor(Color.darkerRed)
            .padding(5)
            .overlay(Rectangle().stroke(Color.darkerRed, lineWidth: 1))
    }

    @ViewBuilder func Origin() -> some View {
        Text(verbatim: product.origin?.name ?? "")
            .font(.caption)
            .foregroundColor(Color.darkerRed)
            .padding(5)
            .overlay(Rectangle().stroke(Color.darkerRed, lineWidth: 1))
    }

    @ViewBuilder func Likes() -> some View {
        HStack(spacing: 3) {
            Image(systemName: "heart.fill")
                .foregroundColor(Color.darkerRed)
            Text(verbatim: String(product.likes))
                .foregroundColor(.gray)
        }
        .font(.caption)
        .padding(5)
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(Color.gray)
        )
        .fixedSize()
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
