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
                        Group {
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
                        .font(.body)
                    }

                    Section(header: Text("Share your invite link").font(.subheadline)) {
                        HStack {
                            Text("\(Urls.ShortReferral)/\(accountViewModel.accountResponse?.referralID ?? "")")
                                .font(.body)

                            Spacer()

                            Button(action: { self.showShareSheet = true }) {
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                        .sheet(isPresented: $showShareSheet,
                               content: {
                                   ActivityView(activityItems: [NSURL(string: "\(Urls.Referral)/\(self.accountViewModel.accountResponse?.referralID ?? "")")!] as [Any], applicationActivities: nil)
                        })
                    }

                    Section(header: Text("Share Bottomless").font(.subheadline)) {
                        Text("Invite people you know to join Bottomless - for every person who signs up, you will get a free bag credit added to your account. Your friend will also get a free bag.")
                            .font(.body)
                            .padding(3)
                    }
                }
            }
            .safeGroupedStyle()
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
