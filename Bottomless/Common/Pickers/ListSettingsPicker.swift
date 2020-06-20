import SwiftUI

struct ListSettingsPicker: View {
    @State var title: String
    @State var indexedValue: Int
    @State var callback: (Int) -> Void
    @State var labels: [String]

    var body: some View {
        Picker(title, selection: $indexedValue.onChange(callback)) {
            ForEach(0 ..< labels.count) { index in
                Text(self.labels[index]).tag(index)
            }
            .navigationBarTitle(title)
        }
        .navigationBarTitle("")
    }
}
