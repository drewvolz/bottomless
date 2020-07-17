import SwiftUI

struct InsetGroupedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(InsetGroupedListStyle())
    }
}

extension List {
    func groupedStyle() -> some View {
        modifier(InsetGroupedViewModifier())
    }
}
