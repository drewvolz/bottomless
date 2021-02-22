extension String {
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
}
