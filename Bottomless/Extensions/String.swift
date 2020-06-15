extension String {
    func uppercaseFirst() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func uppercaseFirst() {
        self = uppercaseFirst()
    }
}
