import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CreateGroupView()) {
                    Text("Create a Group")
                        .padding()
                        .background(.regularMaterial)
                        .colorScheme(.dark)
                        .cornerRadius(12)
                        .font(.largeTitle.bold())
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .navigationTitle("Omu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
