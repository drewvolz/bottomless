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
            VStack(alignment: .center) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 35)
                    .padding([.leading, .trailing], 80)
            }
            .frame(maxHeight: .infinity)

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

            Spacer()
        }
        .navigationBarTitle("Bottomless")
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
}
