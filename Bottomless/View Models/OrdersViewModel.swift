import Combine
import SwiftUI

final class OrdersViewModel: ObservableObject {
    @Published private(set) var ordersResponse: [OrdersResponse]? = []
    @Published private(set) var feedbackResponse: OrdersResponse.ProductFeedback?

    enum FeedbackType: String {
        case Like = "like"
        case Dislike = "dislike"
    }

    private var ordersCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    private var feedbackCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        ordersCancellable?.cancel()
    }

    func fetch() {
        let url = URL(string: Urls.api.orders)!

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        ordersCancellable = publisher
            .map { $0.data }
            .decode(type: OrdersResultResponse.self, decoder: JSONDecoder())
            .map { $0.data as? [OrdersResponse] }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.ordersResponse, on: self)
    }

    func post(orderId: String, feedback: FeedbackType, value: Bool) {
        guard !orderId.isEmpty else { return }

        let urlString = Urls.api.orders + "/\(orderId)/product-feedback"
        let url = URL(string: urlString)!

        let parameterDictionary = [
            feedback.rawValue: value,
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = httpBody

        let publisher = URLSession.shared.dataTaskPublisher(for: request)

        feedbackCancellable = publisher
            .map { $0.data }
            .decode(type: OrdersResponse.ProductFeedback.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.feedbackResponse, on: self)
    }
}
