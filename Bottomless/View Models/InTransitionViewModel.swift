import Combine
import SwiftUI

final class InTransitionViewModel: ObservableObject {
    @Published private(set) var inTransitionResponse: [InTransitionResponse]? = []
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func fetch() {
        fetchProvider.getInTransition()
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                      self.inTransitionResponse = $0.value?.data as? [InTransitionResponse]
                  })
            .store(in: &publishers)
    }
}
