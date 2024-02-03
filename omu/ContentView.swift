import SwiftUI
import FSCalendar

struct Page1: View {
    @State private var groupID: String = ""
    @State private var selectedSubjects: [String] = []
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
                // Handle the action when the submit button is tapped
                // You can add your logic here
                isSubmitTapped = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .frame(width: 200)
            .disabled(groupID.isEmpty)

            NavigationLink(destination: Page2(groupID: groupID, selectedSubjects: selectedSubjects), isActive: $isSubmitTapped) {
                EmptyView()
            }
        }
        .textFieldStyle(.roundedBorder)
        .navigationTitle("Create a group")
    }
}

struct Page2: View {
    var groupID: String
    var selectedSubjects: [String]
    let triviaOfTheDay = "Learn to cook chicken pesto pasta!"

    var body: some View {
        VStack {
            Text("Group ID: \(groupID)")
                .font(.headline)
                .padding()
            
            Spacer()

            Text("Task of the Day:")
                .font(.headline)
                .padding()

            Text(triviaOfTheDay)
                .padding(.leading)

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
