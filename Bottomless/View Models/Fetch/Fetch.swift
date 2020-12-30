//
//  Fetch.swift
//  Bottomless
//
//  Created by Drew Volz on 12/29/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//  https://bitbucket.org/mariwi/implement-swift-generic-api-using-codable-and-combine/
//  https://www.vadimbulavin.com/modern-networking-in-swift-5-with-urlsession-combine-framework-and-codable/
//

import Combine
import SwiftUI

public extension Fetch {
    // MARK: Auth

    func login(credentials: Data) -> FetchResponse.Login {
        return call(Urls.api.auth, method: .POST, body: credentials)
    }

    // MARK: Orders

    func getUpNext() -> FetchResponse.UpNext {
        return call(Urls.api.my, method: .GET)
    }

    func getInTransition() -> FetchResponse.InTransition {
        return call(Urls.api.inTransition, method: .GET)
    }

    func getPastOrders() -> FetchResponse.PastOrders {
        return call(Urls.api.orders, method: .GET)
    }

    // MARK: Scale

    func getScale() -> FetchResponse.Scale {
        return call(Urls.api.scaleStatus, method: .GET)
    }

    func getRecords() -> FetchResponse.Records {
        return call(Urls.api.records, method: .GET)
    }

    func getHeatmap() -> FetchResponse.Heatmap {
        return call(Urls.api.cleanData, method: .GET)
    }

    // MARK: Credits & Referrals

    func getCredits() -> FetchResponse.Credits {
        return call(Urls.api.credits, method: .GET)
    }

    // MARK: Search

    func getProducts() -> FetchResponse.Products {
        return call(Urls.api.products, method: .GET)
    }

    // MARK: Settings

    func getAccount() -> FetchResponse.Account {
        return call(Urls.api.me, method: .GET)
    }

    func setAlertPreferences(settings: Data) -> FetchResponse.Account {
        return call(Urls.api.alerts, method: .POST, body: settings)
    }

    func setOrderingStrategy(level: Data) -> FetchResponse.Account {
        return call(Urls.api.orderingStrategy, method: .POST, body: level)
    }

    func setAccountPaused(status: Data) -> FetchResponse.Account {
        return call(Urls.api.pauseAccount, method: .POST, body: status)
    }
}

public class Fetch: FetchProvider, ObservableObject {
    enum Method: String {
        case GET
        case POST
    }

    public init() {}

    private func call<T: Codable>(_ url: String, method: Method, body: Data = Data(), cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy) -> AnyPublisher<Response<T>, Error> {
        let urlRequest = request(for: url, method: method, body: body, cachePolicy: cachePolicy)

        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func request(for url: String, method: Method, body: Data, cachePolicy: URLRequest.CachePolicy) -> URLRequest {
        guard let url = URL(string: url) else { preconditionFailure("Bad URL") }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = cachePolicy

        if !body.isEmpty {
            request.httpBody = body
        }

        return request
    }
}
