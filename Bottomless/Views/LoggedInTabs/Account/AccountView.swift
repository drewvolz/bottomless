
import SwiftUI

struct AccountView: View {
    @ObservedObject var accountViewModel = AccountViewModel()

    @State private var showShareSheet = false

    var body: some View {
        Group {
            List {
                Group {
                    Section(header: Text("Membership").font(.subheadline)) {
                        Group {
                            HStack {
                                Text("Email")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.local?.email ?? "")")
                            }

                            HStack {
                                Text("Next renewal date")
                                Spacer()
                                Text("\(formatAsRelativeDate(string: accountViewModel.accountResponse?.paidUntil ?? ""))")
                            }

                            HStack {
                                Text("Billing frequency")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.feeFrequency?.uppercaseFirst() ?? "")")
                            }

                            HStack {
                                Text("Fee")
                                Spacer()
                                Text(verbatim: asCurrency(number: accountViewModel.accountResponse?.pricingRule?.monthlyFee))
                            }

                            HStack {
                                Text("Shipping")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.pricingRule?.freeShipping == true ? "Free" : "")")
                            }
                        }
                        .font(.body)
                    }

                    Section(header: Text("Shipping details").font(.subheadline)) {
                        Group {
                            HStack {
                                Text("Name")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.firstName ?? "") \(accountViewModel.accountResponse?.lastName ?? "")")
                            }

                            HStack {
                                Text("Address 1")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.verifiedAddress?.street1 ?? "")")
                            }

                            HStack {
                                Text("Address 2")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.verifiedAddress?.street2 ?? "")")
                            }

                            HStack {
                                Text("Zip code")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.verifiedAddress?.zip ?? "")")
                            }

                            HStack {
                                Text("City")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.verifiedAddress?.city ?? "")")
                            }

                            HStack {
                                Text("State")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.verifiedAddress?.state ?? "")")
                            }
                        }
                        .font(.body)
                    }

                    Section(header: Text("Billing details").font(.subheadline)) {
                        Group {
                            HStack {
                                Text("Card type")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.stripeBrand ?? "")")
                            }

                            HStack {
                                Text("Last 4 digits")
                                Spacer()
                                Text("\(accountViewModel.accountResponse?.stripeLastFour ?? "")")
                            }
                        }
                        .font(.body)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
        }
        .onAppear(perform: fetch)
    }

    private func fetch() {
        accountViewModel.fetch()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AccountView()
            }
        }
    }
}
