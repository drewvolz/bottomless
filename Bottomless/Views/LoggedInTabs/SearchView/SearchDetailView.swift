import ContactsUI
import SwiftUI

struct SearchDetailView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    var product: ProductResponse

    var tags: [String]? {
        product.tags?.compactMap { tag in tag.name }
    }

    var body: some View {
        Group {
            List {
                Section {
                    HStack {
                        UrlImageView(urlString: self.product.smallImageSrc)

                        VStack(alignment: .leading) {
                            Text(verbatim: product.name ?? "")
                                .font(.title)
                                .bold()

                            Text(verbatim: product.vendorName ?? "")
                                .font(.subheadline)
                        }
                    }.padding(.vertical, 12)
                }

                Section(header: Text("Roast and Origin").font(.subheadline)) {
                    Text(verbatim: self.product.roast?.name ?? "")
                        .font(.body)
                    Text(verbatim: self.product.origin?.name ?? "")
                        .font(.body)
                }

                Group {
                    if product.tags?.count ?? 0 > 0 {
                        Section(header: Text("Tags").font(.subheadline)) {
                            ForEach(tags ?? [], id: \.self) { tag in
                                Text(tag)
                                    .font(.body)
                            }
                        }
                    }
                }

                if product.description != "" {
                    Section(header: Text("Description").font(.subheadline)) {
                        Text(verbatim: product.description ?? "")
                            .font(.body)
                            .padding(.vertical)
                    }
                }
            }
            .safeGroupedStyle()
        }
    }
}

struct SearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SearchDetailView(searchViewModel: SearchViewModel(), product: mockProducts.data.first!)
            }
        }
    }
}
