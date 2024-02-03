import SwiftUI
import FSCalendar
import MathExpression

struct Page1: View {
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

            NavigationLink(destination: Dashboard(groupID: groupID), isActive: $isSubmitTapped) {
                EmptyView()
            }
        }
        .textFieldStyle(.roundedBorder)
        .navigationTitle("Create a group")
    }
}

struct Dashboard: View {
    @State private var isStartButtonTapped: Bool = false
    var groupID: String

    var body: some View {
        VStack {
            Text("Group ID: \(groupID)")
                .font(.headline)
                .padding()
            
            Spacer()

            Button("Start") {
                isStartButtonTapped = true
            }
            .frame(width: 150, height: 150)
            .background(
                NavigationLink("", destination: CountdownGameView(), isActive: $isStartButtonTapped)
            )
            .overlay(
                NavigationLink("", destination: CountdownGameView(), isActive: $isStartButtonTapped)
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
    }
}

struct CountdownGameView: View {
    @State private var countdown: Int = 60
    @State private var isGameRunning: Bool = true
    @State private var expression: String = ""
    @State private var result: String = ""
    @State private var showAlert: Bool = false
    @State private var alertCountdown: Int = 60
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
                    if value == 90 { // CHANGE LATER
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
                    dismissButton: .default(Text("OK"))
                )
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


struct CalendarView: UIViewRepresentable {
    typealias UIViewType = FSCalendar

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        // Update any configuration or additional setup here
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, FSCalendarDelegate {
        var parent: CalendarView

        init(_ parent: CalendarView) {
            self.parent = parent
        }
        
        // Implement any FSCalendarDelegate methods if needed
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Page1()) {
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
