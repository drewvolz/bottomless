//
//  FetchProvider.swift
//  Bottomless
//
//  Created by Drew Volz on 12/29/20.
//  Copyright © 2020 Drew Volz. All rights reserved.
//

import Combine
import Foundation

public struct Response<T> {
    let value: T
    let response: URLResponse
}

public enum FetchResponse {
    // MARK: Auth

    public typealias Login = AnyPublisher<Response<LoginResultResponse?>, Error>

    // MARK: Orders

    public typealias UpNext = AnyPublisher<Response<UpNextResponse?>, Error>
    public typealias InTransition = AnyPublisher<Response<InTransitionResultResponse?>, Error>
    public typealias PastOrders = AnyPublisher<Response<OrdersResultResponse?>, Error>

    // MARK: Scale

    public typealias Scale = AnyPublisher<Response<ScaleResponse?>, Error>
    public typealias Records = AnyPublisher<Response<RecordsResultResponse?>, Error>
    public typealias Heatmap = AnyPublisher<Response<CleanDataResponse?>, Error>

    // MARK: Credits & Referrals

    public typealias Credits = AnyPublisher<Response<CreditsResponse?>, Error>

    // MARK: Search

    public typealias Products = AnyPublisher<Response<ProductResultResponse?>, Error>

    // MARK: Settings

    public typealias Account = AnyPublisher<Response<AccountResponse?>, Error>
    public typealias AlertPreferences = AnyPublisher<Response<AccountResponse?>, Error>
    public typealias OrderingStrategy = AnyPublisher<Response<AccountResponse?>, Error>
    public typealias AccountPaused = AnyPublisher<Response<AccountResponse?>, Error>
}

public protocol FetchProvider {
    // MARK: Auth

    func login(credentials: Data) -> FetchResponse.Login

    // MARK: Orders

    func getUpNext() -> FetchResponse.UpNext
    func getInTransition() -> FetchResponse.InTransition
    func getPastOrders() -> FetchResponse.PastOrders

    // MARK: Scale

    func getScale() -> FetchResponse.Scale
    func getRecords() -> FetchResponse.Records
    func getHeatmap() -> FetchResponse.Heatmap

    // MARK: Credits & Referrals

    func getCredits() -> FetchResponse.Credits

    // MARK: Search

    func getProducts() -> FetchResponse.Products

    // MARK: Settings

    func getAccount() -> FetchResponse.Account
    func setAlertPreferences(settings: Data) -> FetchResponse.AlertPreferences
    func setOrderingStrategy(level: Data) -> FetchResponse.OrderingStrategy
    func setAccountPaused(status: Data) -> FetchResponse.AccountPaused
}
