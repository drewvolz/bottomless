import SwiftUI

struct OrdersView: View {
    @ObservedObject var upNextViewModel = UpNextViewModel()
    @ObservedObject var inTransitionViewModel = InTransitionViewModel()
    @ObservedObject var pastOrdersViewModel = OrdersViewModel()

    var body: some View {
        Group {
            List {
                Group {
                    if hasUpNextOrder(order: upNextViewModel.upNextResponse) {
                        Section(header: Text("Up Next").font(.subheadline)) {
                            UpNextOrder(order: upNextViewModel.upNextResponse!)
                        }
                    }

                    if hasInTransitionOrders(orders: inTransitionViewModel.inTransitionResponse) {
                        Section(header: Text("Orders In Progress").font(.subheadline)) {
                            ForEach(inTransitionViewModel.inTransitionResponse ?? []) { order in
                                InProgressOrder(order: order)
                            }
                        }
                    }

                    if hasPastOrders(orders: pastOrdersViewModel.ordersResponse) {
                        Section(header: Text("Past Orders").font(.subheadline)) {
                            ForEach(pastOrdersViewModel.ordersResponse ?? []) { order in
                                PastOrder(order: order)
                            }
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
        return Array(arrayLiteral: orders).count > 0
    }

    private func hasPastOrders(orders: [OrdersResponse]?) -> Bool {
        return Array(arrayLiteral: orders).count > 0
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