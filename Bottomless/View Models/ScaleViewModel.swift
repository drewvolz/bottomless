import Combine
import SwiftUI

final class ScaleViewModel: ObservableObject {
    @Published private(set) var scaleResponse: ScaleResponse?
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func fetch() {
        fetchProvider.getScale()
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.scaleResponse = $0.value })
            .store(in: &publishers)
    }
}
