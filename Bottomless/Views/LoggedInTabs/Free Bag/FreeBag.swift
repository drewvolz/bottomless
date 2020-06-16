import SwiftUI

struct FreeBagView: View {
    @ObservedObject var creditsViewModel = CreditsViewModel()
    @ObservedObject var accountViewModel = AccountViewModel()

    @State private var showShareSheet = false

    var body: some View {
        Group {
            List {
                Group {
                    Section(header:
                        Group {
                            HStack(alignment: .center) {
                                Image(systemName: "gift")
                                Text("Your free bag credits")
                                    .font(.subheadline)
                            }
                    }) {
                        HStack {
                            Text("Granted")
                            Spacer()
                            Text("\(creditsViewModel.creditsResponse?.granted ?? 0)")
                        }

                        HStack {
                            Text("Redeemed")
                            Spacer()
                            Text("\(creditsViewModel.creditsResponse?.redeemed ?? 0)")
                        }

                        HStack {
                            Text("Total Earned")
                            Spacer()
                            Text("\(creditsViewModel.creditsResponse?.id ?? 0)")
                        }
                    }

                    Section(header: Text("Share your invite link").font(.subheadline)) {
                        HStack {
                            Text("\(App.Referral)/\(accountViewModel.accountResponse?.referralID ?? "")")
                                .font(.caption)

                            Spacer()

                            Button(action: { self.showShareSheet = true }) {
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                        .sheet(isPresented: $showShareSheet,
                               content: {
                                   ActivityView(activityItems: [NSURL(string: "\(App.Referral)/\(self.accountViewModel.accountResponse?.referralID ?? "")")!] as [Any], applicationActivities: nil)
                        })
                    }

                    Section(header: Text("Share Bottomless").font(.subheadline)) {
                        Text("Invite people you know to join Bottomless - for every person who signs up, you will get a free bag credit added to your account. Your friend will also get a free bag.")
                            .font(.subheadline)
                            .padding(3)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
        }
        .onAppear(perform: fetch)
    }

    private func fetch() {
        creditsViewModel.fetch()
        accountViewModel.fetch()
    }
}

struct FreeBagView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                FreeBagView()
            }
        }
    }
}
