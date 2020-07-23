import SwiftUI

public struct NavItem: Identifiable {
    public let id: Int
    let name: String
    let icon: String
    let destination: AnyView
}

public var navigationItems = [
    NavItem(id: 0,
            name: "Orders",
            icon: "heart",
            destination: AnyView(OrdersView())),

    NavItem(id: 1,
            name: "Scale",
            icon: "chart.bar",
            destination: AnyView(DataView())),

    NavItem(id: 2,
            name: "Free Bag",
            icon: "gift",
            destination: AnyView(FreeBagView())),

    NavItem(id: 3,
            name: "Search",
            icon: "magnifyingglass",
            destination: AnyView(SearchView())),

    NavItem(id: 4,
            name: "Settings",
            icon: "wrench",
            destination: AnyView(AccountView())),
]
