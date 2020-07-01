import Combine
import SwiftUI

final class RecordsViewModel: ObservableObject {
    @Published private(set) var recordsResponse: [RecordsResponse]? = []

    private var recordsCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        recordsCancellable?.cancel()
    }

    func fetch() {
        let url = URL(string: App.api.records)!

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        recordsCancellable = publisher
            .map { $0.data }
            .decode(type: RecordsResultResponse.self, decoder: JSONDecoder())
            .map { $0.data as? [RecordsResponse] }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.recordsResponse, on: self)
    }
}
