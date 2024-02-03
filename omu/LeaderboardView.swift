import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack {
            Text("Today's Leaderboard")
                .font(.largeTitle)
                .padding()

            LeaderboardRow(name: "🥇Memi", time: "5 seconds")
            LeaderboardRow(name: "🥈Scott", time: "42 seconds")
            LeaderboardRow(name: "🥉Tommy", time: "50 seconds")
            LeaderboardRow(name: "Jerome", time: "55 seconds")
            LeaderboardRow(name: "Sonny", time: "59 seconds")
            LeaderboardRow(name: "Hoang", time: "FAIL")
        }
    }
}

struct LeaderboardRow: View {
    var name: String
    var time: String

    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(time)
        }
        .padding()
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
