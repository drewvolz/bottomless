import Combine
import SwiftUI
import WidgetKit

final class UpNextViewModel: ObservableObject {
    @Published private(set) var upNextResponse: UpNextResponse?
    private var publishers = [AnyCancellable]()
    private let fetchProvider = Fetch()

    func fetch() {
        fetchProvider.getUpNext()
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                      self.upNextResponse = $0.value
                      self.updateOrdersWidget(value: $0.value)
            })
            .store(in: &publishers)
    }

    func updateOrdersWidget(value: UpNextResponse?) {
        do {
            if let response = value {
                let jsonData = try JSONEncoder().encode(response as UpNextResponse)
                let json = String(data: jsonData, encoding: String.Encoding.utf8)

                UserDefaults(suiteName: Keys.SharedGroupID)!.setValue(json, forKey: Keys.UpNextOrder)

                WidgetCenter.shared.reloadTimelines(ofKind: Keys.OrdersWidgetID)
            }
        } catch {
            print("Error in saving UpNextResponse to \(Keys.SharedGroupID): \(error.localizedDescription)")
        }
    }
}
