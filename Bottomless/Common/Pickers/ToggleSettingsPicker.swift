import SwiftUI

struct ToggleSettingsPicker: View {
    @State var title: String
    @State var value: Bool
    @State var callback: (Bool) -> Void

    var body: some View {
        Toggle(isOn: $value.onChange(callback)) {
            Text("Gif alerts")
        }
    }
}
