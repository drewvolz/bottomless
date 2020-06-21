import SwiftUI

struct PrimaryButton: View {
    let title: String

    var body: some View {
        Text(title.uppercased())
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .cornerRadius(5)
    }
}

struct _PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title.uppercased())
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .background(Color.accentColor)
        .cornerRadius(5)
    }
}

struct SecondaryButton: View {
    let title: String

    var body: some View {
        Text(title.uppercased())
            .fontWeight(.bold)
            .foregroundColor(.accentColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(5)
    }
}

struct _SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title.uppercased())
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .background(Color.white)
        .cornerRadius(5)
    }
}

struct SecondaryTextButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity)
        }
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PrimaryButton(title: "Primary")
                .previewLayout(.fixed(width: 300, height: 100))
            SecondaryButton(title: "Secondary")
                .previewLayout(.fixed(width: 300, height: 100))
        }
    }
}
