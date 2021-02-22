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
}
