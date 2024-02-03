import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack {
            Text("Today's Leaderboard")
                .font(.largeTitle)
                .padding()

            // You can display fake leaderboard data here
            LeaderboardRow(name: "Memi", time: "5 seconds")
            LeaderboardRow(name: "Scott", time: "42 seconds")
            LeaderboardRow(name: "Tommy", time: "50 seconds")
            LeaderboardRow(name: "Jerome", time: "55 seconds")
            LeaderboardRow(name: "Sonny", time: "60 seconds")
            LeaderboardRow(name: "Sonny", time: "FAIL")
        }
    }
}

struct LeaderboardRow: View {
    var name: String
    var time: String

    var body: some View {
        HStack {
            Text(name)
                .padding(.trailing) // Adjust padding here
            Spacer()
            Text(time)
                .padding(.leading) // Adjust padding here
        }
        .padding(.vertical, 8) // Adjust vertical padding here
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
