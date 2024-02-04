import SwiftUI

struct CreateUserView: View {
    @State private var playerName: String = ""
    @State private var isSubmitTapped: Bool = false

    var body: some View {
        VStack {
            TextField(
                "Username",
                text: $playerName
            )
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            .font(.system(size: 14))
            .frame(width: 200)

            Button("Submit") {
                isSubmitTapped = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .frame(width: 200)
            .disabled(playerName.isEmpty)

            NavigationLink(destination: DashboardView(playerName: playerName), isActive: $isSubmitTapped) {
                EmptyView()
            }
        }
        .textFieldStyle(.roundedBorder)
//        .navigationTitle("Create a group")
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
