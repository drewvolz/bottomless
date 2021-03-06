import Foundation

var mockUpNext: UpNextResponse = load("up-next.json")
var mockInTransition: InTransitionResponse = load("in-transition.json")
var mockOrders: OrdersResponse = load("orders.json")
var mockRecords: RecordsResultResponse = load("records.json")
var mockCleanData: CleanDataResponse = load("clean-data.json")
var mockProducts: ProductResultResponse = load("products.json")

func load<T: Decodable>(_ filename: String, as _: T.Type = T.self) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
