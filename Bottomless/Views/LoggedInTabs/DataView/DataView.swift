import SwiftUI

struct DataView: View {
    @ObservedObject var recordsViewModel = RecordsViewModel()
    @ObservedObject var scaleViewModel = ScaleViewModel()

    var weights: [Double]? {
        recordsViewModel.recordsResponse?.compactMap {
            record in record.adjusted_weight
        }.filter { $0 > 0 }
    }

    var body: some View {
        Group {
            List {
                Group {
                    Section {
                        ScaleView(viewModel: scaleViewModel)
                    }

                    Group {
                        Section {
                            LineView(data: weights?.reversed() ?? [], title: "")
                        }
                        .padding(.top, 150)
                        .frame(height: 200)
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
