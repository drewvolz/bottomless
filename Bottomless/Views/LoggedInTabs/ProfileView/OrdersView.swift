import SwiftUI

struct OrdersView: View {
    @ObservedObject var upNextViewModel = UpNextViewModel()
    @ObservedObject var inTransitionViewModel = InTransitionViewModel()
    @ObservedObject var pastOrdersViewModel = OrdersViewModel()

    var body: some View {
        Group {
            List {
                Group {
                    Section(header:
                        Text("Up Next")
                            .font(.subheadline)
                            .accessibilityIdentifier(Keys.Orders.UpNextHeader)) {
                            UpNextSection()
                    }

                    Section(header:
                        Text("Orders In Progress")
                            .font(.subheadline)
                            .accessibilityIdentifier(Keys.Orders.InProgressHeader)) {
                            InProgressSection()
                    }

                    Section(header:
                        Text("Past Orders")
                            .font(.subheadline)
                            .accessibilityIdentifier(Keys.Orders.PastHeader)) {
                            PastSection()
                    }
                }
            }
            .groupedStyle()
            .accessibilityIdentifier(Keys.Orders.List)
        }
        .onAppear(perform: fetch)
    }
}

// MARK: views

private extension OrdersView {
    @ViewBuilder func UpNextSection() -> some View {
        if hasUpNextOrder(order: upNextViewModel.upNextResponse) {
            UpNextOrder(order: upNextViewModel.upNextResponse!)
        } else {
            NoOrders(message: "No upcoming orders")
        }
    }

    @ViewBuilder func InProgressSection() -> some View {
        if hasInTransitionOrders(orders: inTransitionViewModel.inTransitionResponse) {
            ForEach(inTransitionViewModel.inTransitionResponse!) { order in
                InProgressOrder(order: order)
            }
        } else {
            NoOrders(message: "No orders in progress")
        }
    }

    @ViewBuilder func PastSection() -> some View {
        if hasPastOrders(orders: pastOrdersViewModel.ordersResponse) {
            ForEach(pastOrdersViewModel.ordersResponse!) { order in
                PastOrder(order: order)
            }
        } else {
            NoOrders(message: "No past orders")
        }
    }
}

// MARK: functions

private extension OrdersView {
    func fetch() {
        upNextViewModel.fetch()
        inTransitionViewModel.fetch()
        pastOrdersViewModel.fetch()
    }

    func hasInTransitionOrders(orders: [InTransitionResponse]?) -> Bool {
        var hasOrders = false
        if let count = orders?.count {
            hasOrders = count > 0
        }

        return hasOrders
    }

    func hasPastOrders(orders: [OrdersResponse]?) -> Bool {
        var hasOrders = false
        if let count = orders?.count {
            hasOrders = count > 0
        }

        return hasOrders
    }

    func hasUpNextOrder(order: UpNextResponse?) -> Bool {
        return order != nil
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                OrdersView()
            }
        }
    }
}
