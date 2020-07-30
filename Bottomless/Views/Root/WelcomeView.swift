import SwiftUI

struct WelcomeView: View {
    private enum PresentedView {
        case login
        case register
    }

    @State private var presentedView: PresentedView?
    @State var showsAlert = false

    var body: some View {
        VStack(alignment: .leading) {
            Logo()
            LoginSignup()
            Spacer()
        }
        .navigationBarTitle("Bottomless")
    }
}

private extension WelcomeView {
    @ViewBuilder func Logo() -> some View {
        VStack(alignment: .center) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 35)
                .padding([.leading, .trailing], 80)
        }
        .frame(maxHeight: .infinity)
    }

    @ViewBuilder func LoginSignup() -> some View {
        VStack(spacing: 30) {
            NavigationLink(destination: LoginView()) {
                PrimaryButton(title: "Log In")
            }

            NavigationLink(destination: EmptyView()) {
                _SecondaryButton(title: "Sign Up") {
                    self.showsAlert.toggle()
                }
                .alert(isPresented: self.$showsAlert) {
                    Alert(title: Text("Not supported 😬"))
                }
            }
        }
        .padding([.leading, .bottom, .trailing])
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                WelcomeView()
            }
        }
    }
}
