import SwiftUI

struct DashboardView: View {
    @State private var isStartButtonTapped: Bool = false
    var playerName: String

    var body: some View {
        VStack {
            Text("Username: \(playerName)")
                .font(.headline)
                .padding()
            
            Spacer()

            Button("Start Game") {
                isStartButtonTapped = true
            }
            .frame(width: 150, height: 150)
            .background(
                NavigationLink("", destination: GameView(), isActive: $isStartButtonTapped)
            )
            .overlay(
                NavigationLink("", destination: GameView(), isActive: $isStartButtonTapped)
                    .frame(width: 0, height: 0)
            )

            Spacer()

            NavigationLink(destination: CalendarView()) {
                Image(systemName: "calendar")
                    .imageScale(.large)
                    .padding()
                    .foregroundColor(.blue)
            }
            .padding(.trailing)
        }
        .navigationTitle("Dashboard")
        .navigationBarBackButtonHidden(true)
    }
}
