import SwiftUI

struct OrdersView: View {
    @ObservedObject var upNextViewModel = UpNextViewModel()
    @ObservedObject var inTransitionViewModel = InTransitionViewModel()
    @ObservedObject var pastOrdersViewModel = OrdersViewModel()

    var PlaceholderOrder: some View {
        UpNextOrder(order: mockUpNext).redacted(reason: .placeholder)
    }

    var body: some View {
        Group {
            List {
                Group {
                    Section(header: Text("Up Next").font(.subheadline)) {
                        if hasUpNextOrder(order: upNextViewModel.upNextResponse) {
                            UpNextOrder(order: upNextViewModel.upNextResponse!)
                        } else {
                            NoOrders(message: "No upcoming orders")
                        }
                    }

                    Section(header: Text("Orders In Progress").font(.subheadline)) {
                        if inTransitionViewModel.inTransitionResponse?.isEmpty == true {
                            PlaceholderOrder
                        } else if hasInTransitionOrders(orders: inTransitionViewModel.inTransitionResponse) {
                            ForEach(inTransitionViewModel.inTransitionResponse!) { order in
                                InProgressOrder(order: order)
                            }
                        } else {
                            NoOrders(message: "No orders in progress")
                        }
                    }

                    Section(header: Text("Past Orders").font(.subheadline)) {
                        if pastOrdersViewModel.ordersResponse?.isEmpty == true {
                            PlaceholderOrder
                        } else if hasPastOrders(orders: pastOrdersViewModel.ordersResponse) {
                            ForEach(pastOrdersViewModel.ordersResponse!) { order in
                                PastOrder(order: order)
                            }
                        } else {
                            NoOrders(message: "No past orders")
                        }
                    }
                }
            }
            .groupedStyle()
        }
        .onAppear(perform: fetch)
    }

    private func fetch() {
        upNextViewModel.fetch()
        inTransitionViewModel.fetch()
        pastOrdersViewModel.fetch()
    }

    private func hasInTransitionOrders(orders: [InTransitionResponse]?) -> Bool {
        var hasOrders = false
        if let count = orders?.count {
            hasOrders = count > 0
        }

        return hasOrders
    }

    private func hasPastOrders(orders: [OrdersResponse]?) -> Bool {
        var hasOrders = false
        if let count = orders?.count {
            hasOrders = count > 0
        }

        return hasOrders
    }

    private func hasUpNextOrder(order: UpNextResponse?) -> Bool {
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
