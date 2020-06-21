import SwiftUI

struct ToggleSettingsPicker: View {
    @State var title: String
    @State var value: Bool
    @State var callback: (Bool) -> Void

    var body: some View {
        Toggle(isOn: $value.onChange(callback)) {
            Text(title)
        }
    }
}

struct ToggleSettingsPicker_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            ToggleSettingsPicker(title: "Toggle me",
                                 value: true,
                                 callback: { _ in print("Toggled!") })
        }
    }
}
