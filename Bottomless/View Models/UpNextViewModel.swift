import Combine
import SwiftUI

final class UpNextViewModel: ObservableObject {
    @Published private(set) var upNextResponse: UpNextResponse?
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func fetch() {
        fetchProvider.getUpNext()
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.upNextResponse = $0.value })
            .store(in: &publishers)
    }
}
