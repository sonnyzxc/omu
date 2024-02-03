import SwiftUI
import MathExpression

struct GameView: View {
    @State private var countdown: Int = 60
    @State private var isGameRunning: Bool = true
    @State private var expression: String = ""
    @State private var result: String = ""
    @State private var showAlert: Bool = false
    @State private var alertCountdown: Int = 60
    @State private var navigateToLeaderboard: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Countdown Game Show")
                .font(.headline)
                .padding()
            
            Text("598")
                .font(.system(size: 50, weight: .bold))
            
            HStack(spacing: 30) {
                ForEach(["9", "4", "2", "1", "9", "5"], id: \.self) { number in
                    Button(action: {
                        expression += number + " "
                    }) {
                        Text(number)
                            .font(.system(size: 40))
                    }
                }
            }
            
            HStack(spacing: 30) {
                ForEach(["+", "-", "*", "/", "(", ")"], id: \.self) { ops in
                    Button(action: {
                        expression += ops + " "
                    }) {
                        Text(ops)
                            .font(.system(size: 40))
                    }
                }
            }
            
            HStack(spacing: 30) {
                ForEach(["DEL"], id: \.self) { ops in
                    Button(action: {
                        expression = String(expression.dropLast(2))
                    }) {
                        Text(ops)
                            .font(.system(size: 40))
                    }
                }
            }
            
            Text("\(expression)")
                .font(.system(size: 20))
                .padding()
            
            Spacer()
            
            Button("Submit") {
                do {
                    let expression = try MathExpression("\(expression)")
                    let value = expression.evaluate()
                    print("\(expression) = \(value)")
                    if value == 90 { // TODO: CHANGE LATER
                        print("success!")
                        showAlert = true
                    }
                } catch {
                    print("Error evaluating math expression: \(error)")
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Congratulations!"),
                    message: Text("You solved it in \(60 - countdown) seconds!"),
                    dismissButton: .default(Text("OK"), action: {
                        navigateToLeaderboard = true
                    })
                )
            }
            .sheet(isPresented: $navigateToLeaderboard) {
                LeaderboardView()
            }


            Text("Time Remaining: \(countdown) seconds")
                .foregroundColor(countdown <= 10 ? .red : .primary)
                .font(.subheadline)
                .padding()

            if !isGameRunning {
                Text("Game Over!")
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding()
            }
        }
        .onReceive(timer) { _ in
            if isGameRunning {
                if countdown > 0 {
                    if !showAlert {
                        countdown -= 1
                    }
                } else {
                    isGameRunning = false
                }
            }
        }
    }
}

#Preview {
    GameView()
}
