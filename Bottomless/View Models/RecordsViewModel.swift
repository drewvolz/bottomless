import Combine
import SwiftUI

final class RecordsViewModel: ObservableObject {
    @Published private(set) var recordsResponse: [RecordsResponse]? = []
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func fetch() {
        fetchProvider.getRecords()
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                      self.recordsResponse = $0.value?.data as? [RecordsResponse]
                  })
            .store(in: &publishers)
    }
}
