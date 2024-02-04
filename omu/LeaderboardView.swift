import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack {
            Text("Today's Leaderboard")
                .font(.largeTitle)
                .padding()

            LeaderboardRow(name: "🥇Memi", time: "5 seconds")
                .background(.yellow)
                .foregroundStyle(.white)
            LeaderboardRow(name: "🥈Scott", time: "42 seconds")
                .background(.gray)
                .foregroundStyle(.white)
            LeaderboardRow(name: "🥉Tommy", time: "50 seconds")
                .background(.brown)
                .foregroundStyle(.white)
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

#Preview {
    LeaderboardView()
}
