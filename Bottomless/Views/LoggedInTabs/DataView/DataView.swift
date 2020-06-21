import SwiftUI
import SwiftUICharts

struct DataView: View {
    @ObservedObject var recordsViewModel = RecordsViewModel()
    @ObservedObject var scaleViewModel = ScaleViewModel()

    var weights: [Double]? {
        recordsViewModel.recordsResponse?.compactMap {
            record in record.adjusted_weight
        } /* .filter { $0 > 0 } */
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
                        Group {
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
                                Text("\(formatAsRelativeTime(string: scaleViewModel.scaleResponse?.scale_last_connected ?? ""))")
                            }
                        }
                        .font(.body)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
        }
        .onAppear(perform: fetch)
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
