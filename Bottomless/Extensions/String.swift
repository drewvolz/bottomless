import Foundation

extension String {
    // MARK: Capitalize

    func uppercaseFirst() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func uppercaseFirst() {
        self = uppercaseFirst()
    }

    // MARK: Whitespace

    func trimWhitespace() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    mutating func trimWhitespace() {
        self = trimWhitespace()
    }

    // MARK: Special characters

    func forSearch() -> String {
        return folding(options: .diacriticInsensitive, locale: .current)
    }

    mutating func forSearch() {
        self = forSearch()
    }

    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue,
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)
    }
}
