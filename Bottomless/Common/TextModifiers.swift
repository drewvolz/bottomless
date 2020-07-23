import SwiftUI

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font
                .title
                .weight(.bold))
            .foregroundColor(.body)
    }
}

struct BodyText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.body)
    }
}

struct NavbarIcon: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(minWidth: 30)
    }
}
