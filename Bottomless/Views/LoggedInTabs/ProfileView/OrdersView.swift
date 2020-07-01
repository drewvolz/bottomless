import SwiftUI

struct OrdersView: View {
    @ObservedObject var upNextViewModel = UpNextViewModel()
    @ObservedObject var inTransitionViewModel = InTransitionViewModel()
    @ObservedObject var pastOrdersViewModel = OrdersViewModel()

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
                        if hasInTransitionOrders(orders: inTransitionViewModel.inTransitionResponse) {
                            ForEach(inTransitionViewModel.inTransitionResponse!) { order in
                                InProgressOrder(order: order)
                            }
                        } else {
                            NoOrders(message: "No orders in progress")
                        }
                    }

                    Section(header: Text("Past Orders").font(.subheadline)) {
                        if hasPastOrders(orders: pastOrdersViewModel.ordersResponse) {
                            ForEach(pastOrdersViewModel.ordersResponse!) { order in
                                PastOrder(order: order)
                            }
                        } else {
                            NoOrders(message: "No past orders")
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
        }
        .onAppear(perform: fetch)
    }

    private func fetch() {
        upNextViewModel.fetch()
        inTransitionViewModel.fetch()
        pastOrdersViewModel.fetch()
    }

    private func hasInTransitionOrders(orders: [InTransitionResponse]?) -> Bool {
        return orders!.count > 0
    }

    private func hasPastOrders(orders: [OrdersResponse]?) -> Bool {
        return orders!.count > 0
    }

    private func hasUpNextOrder(order: UpNextResponse?) -> Bool {
        // TODO: this is not yet the correct check
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
