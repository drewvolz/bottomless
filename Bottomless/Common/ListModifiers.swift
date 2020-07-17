import SwiftUI

@available(iOS 14.0, *)
struct InsetGroupedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(InsetGroupedListStyle())
    }
}

struct GroupedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
    }
}

extension List {
    func safeGroupedStyle() -> some View {
        guard #available(iOS 14, *) else {
            return AnyView(modifier(GroupedViewModifier()))
        }

        return AnyView(modifier(InsetGroupedViewModifier()))
    }
}
