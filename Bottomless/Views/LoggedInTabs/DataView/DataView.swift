import SwiftUI
import SwiftUICharts

struct DataView: View {
    @ObservedObject var recordsViewModel = RecordsViewModel()
    @ObservedObject var scaleViewModel = ScaleViewModel()

    var weights: [Double]? {
        recordsViewModel.recordsResponse.flatMap { record in
            record.compactMap { $0.adjusted_weight }
        }
    }

    var body: some View {
        Group {
            List {
                Group {
                    Section {
                        LineView(data: weights?.reversed() ?? [], title: "Scale readings")
                    }
                    // TODO: play with these paddings and make sure they work for all ranges
                    .padding(.top, 140)
                    .padding(.bottom, 180)

                    Section(header: Text("Scale").font(.subheadline)) {
                        HStack {
                            Text("Last weight")
                            Spacer()
                            Text("\(String(format: "%.2f", scaleViewModel.scaleResponse?.scale_last_weight ?? 0))oz")
                        }

                        HStack {
                            Text("Status")
                            Spacer()
                            Text("\(scaleViewModel.scaleResponse?.id?.uppercaseFirst() ?? "Unknown")")
                        }

                        HStack {
                            Text("Last connected")
                            Spacer()
                            Text("\(dateFormatted())")
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
        }
        .onAppear(perform: fetch)
    }

    private func dateFormatted() -> String {
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .full

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"

        let someDateTime = formatter.date(from: scaleViewModel.scaleResponse?.scale_last_connected ?? "")
        let relativeDate = relativeFormatter.localizedString(for: someDateTime ?? Date(), relativeTo: Date())

        if relativeDate == "in 0 seconds" { return "…" }

        return relativeDate
    }

    private func fetch() {
        recordsViewModel.fetch()
        scaleViewModel.fetch()
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                DataView()
            }
        }
    }
}
