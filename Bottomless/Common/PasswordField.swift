import SwiftUI

struct PasswordField: View {
    @Binding var value: String

    var header = "Password"
    var placeholder = "Your password"
    var errorMessage = ""
    var showUnderline = true
    var onEditingChanged: ((Bool) -> Void) = { _ in }
    var onCommit: (() -> Void) = {}

    @State var isSecure: Bool = true

    let pasteboard = UIPasteboard.general

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(header.uppercased())
                .font(.footnote)

            HStack {
                ZStack {
                    SecureField(placeholder, text: self.$value, onCommit: {
                        self.onEditingChanged(false)
                    })
                        .padding(.vertical, 15)
                        .opacity(isSecure ? 1 : 0)

                    TextField(placeholder, text: self.$value, onEditingChanged: { flag in
                        self.onEditingChanged(flag)
                    })
                        .padding(.vertical, 15)
                        .opacity(isSecure ? 0 : 1)
                }

                HStack {
                    if isSecure {
                        Image(systemName: "eye.slash").foregroundColor(Color.gray).onTapGesture {
                            withAnimation {
                                self.isSecure.toggle()
                            }
                        }
                    } else {
                        Image(systemName: "doc.on.doc")
                            .foregroundColor(Color.gray)
                            .transition(.opacity)
                            .onTapGesture {
                                self.pasteboard.string = self.value
                            }

                        Image(systemName: "eye").foregroundColor(Color.gray).onTapGesture {
                            withAnimation {
                                self.isSecure.toggle()
                            }
                        }
                    }
                }
            }.frame(height: 45)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .lineLimit(nil)
                    .font(.footnote)
                    .foregroundColor(Color.red)
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }
        }
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordField(value: .constant(""))
    }
}
