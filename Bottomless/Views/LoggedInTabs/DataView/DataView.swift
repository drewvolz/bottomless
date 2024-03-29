import CalendarHeatmap
import SwiftUI
import SwiftUICharts

struct DataView: View {
    @ObservedObject var recordsViewModel = RecordsViewModel()
    @ObservedObject var scaleViewModel = ScaleViewModel()
    @ObservedObject var cleanDataViewModel = CleanDataViewModel()

    let full = Legend(color: .green, label: "Full", order: 4)
    let half = Legend(color: .yellow, label: "Half", order: 3)
    let low = Legend(color: .orange, label: "Low", order: 2)
    let empty = Legend(color: .red, label: "Empty", order: 1)

    private func calculateLegend(weight: Double) -> Legend {
        switch weight {
        case 0 ..< 3:
            return empty
        case 3 ..< 5:
            return low
        case 5 ..< 8:
            return half
        case 8 ..< 12:
            return full
        default:
            return empty
        }
    }

    private func countLabels(for dataPoints: [DataPoint]?) -> Int {
        var labelCount = 0

        if let count = dataPoints?.count {
            labelCount = count >= 3 ? 3 : count
        }

        return labelCount
    }

    var weights: [DataPoint]? {
        recordsViewModel.recordsResponse?.reversed().compactMap { record in
            let relativeTime = formatAsRelativeTime(string: record.timestamp)
            let label = LocalizedStringKey(relativeTime)
            let legend = calculateLegend(weight: record.adjusted_weight)

            return DataPoint(value: record.adjusted_weight,
                             label: label,
                             legend: legend)
        }.filter { $0.endValue > 0 }
    }

    var body: some View {
        Group {
            List {
                Group {
                    Section(header:
                        Text("Summary")
                            .accessibilityIdentifier(Keys.Scale.Summary)) {
                        ScaleView(viewModel: scaleViewModel)
                    }

                    Section(header:
                        Text("Weight")
                            .accessibilityIdentifier(Keys.Scale.Weight)) {
                        BarChartView(dataPoints: weights ?? [])
                            .chartStyle(
                                BarChartStyle(
                                    showAxis: true,
                                    showLabels: true,
                                    labelCount: countLabels(for: weights),
                                    showLegends: false
                                )
                            )
                    }

                    Section(header:
                        Text("Consumption")
                            .accessibilityIdentifier(Keys.Scale.Consumption)) {
                        HeatmapView(viewModel: cleanDataViewModel)
                            .frame(minHeight: 200)
                    }
                }
            }
            .groupedStyle()
            .accessibilityIdentifier(Keys.Scale.List)
            .refreshable(action: fetch)
        }
        .onAppear(perform: fetch)
    }
}

private extension DataView {
    @Sendable func fetch() {
        cleanDataViewModel.fetch()
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
