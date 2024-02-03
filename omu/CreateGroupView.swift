import SwiftUI

struct CreateGroupView: View {
    @State private var groupID: String = ""
    @State private var isSubmitTapped: Bool = false

    var body: some View {
        
        VStack {
            TextField(
                "Group ID",
                text: $groupID
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
            .disabled(groupID.isEmpty)

            NavigationLink(destination: DashboardView(groupID: groupID), isActive: $isSubmitTapped) {
                EmptyView()
            }
        }
        .textFieldStyle(.roundedBorder)
        .navigationTitle("Create a group")
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}
