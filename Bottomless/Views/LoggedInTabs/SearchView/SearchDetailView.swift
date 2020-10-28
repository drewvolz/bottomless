import SwiftUI

struct SearchDetailView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    var product: ProductResponse

    var tags: [String]? {
        product.tags?.compactMap { tag in tag.name }
    }

    var tastingNotes: [String]? {
        product.tastingNotes?.compactMap { note in note.name }
    }

    var variants: [ProductResponse.Variant]? {
        product.variants?.sorted(by: { $0.size! < $1.size! })
            .filter { ($0.available ?? false) }
    }

    var body: some View {
        Group {
            List {
                ImageAndProductInfo()

                if product.likes > 0 {
                    Likes()
                }

                RoastAndOrigin()
                Tags()
                TastingNotes()
                Variants()
                Description()
            }
            .groupedStyle()
        }
    }
}

private extension SearchDetailView {
    @ViewBuilder func ImageAndProductInfo() -> some View {
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
    }

    @ViewBuilder func RoastAndOrigin() -> some View {
        Section(header: Text("Roast and Origin").font(.subheadline)) {
            Text(verbatim: self.product.roast?.name ?? "")
                .font(.body)
            Text(verbatim: self.product.origin?.name ?? "")
                .font(.body)
        }
    }

    @ViewBuilder func Likes() -> some View {
        Section(header: Text("Likes").font(.subheadline)) {
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.darkerRed)
                Text(verbatim: String(product.likes))
            }
            .font(.body)
        }
    }

    @ViewBuilder func Tags() -> some View {
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
    }

    @ViewBuilder func TastingNotes() -> some View {
        Group {
            if product.tastingNotes?.count ?? 0 > 0 {
                Section(header: Text("Tasting Notes").font(.subheadline)) {
                    ForEach(tastingNotes ?? [], id: \.self) { note in
                        Text(note)
                            .font(.body)
                    }
                }
            }
        }
    }

    @ViewBuilder func Variants() -> some View {
        Group {
            if product.variants?.count ?? 0 > 0 {
                Section(header: Text("Variants").font(.subheadline)) {
                    ForEach(variants ?? [], id: \.self) { variant in
                        HStack(alignment: .firstTextBaseline) {
                            if let size = variant.size {
                                Text(String(size) + "oz")
                                    .font(.body)

                                Spacer()

                                if let price = variant.price {
                                    Text("$\(String(format: "%.2f", price)) ($\(String(format: "%.2f", price / Double(size)))/oz)")
                                        .font(.body)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder func Description() -> some View {
        if product.description != "" {
            Section(header: Text("Description").font(.subheadline)) {
                Text(verbatim: product.description ?? "")
                    .font(.body)
                    .padding(.vertical)
            }
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
