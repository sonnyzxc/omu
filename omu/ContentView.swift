import SwiftUI
import FSCalendar

struct Page1: View {
    @State private var groupID: String = ""
    @State private var selectedSubjects: [String] = []
    @State private var isSubmitTapped: Bool = false
    
    let academicSubjects = ["Math", "Science", "English", "History", "Computer Science"]
    
    var body: some View {
        VStack{
            List(academicSubjects, id: \.self) { subject in
                Toggle(isOn: Binding(
                    get: { selectedSubjects.contains(subject) },
                    set: {
                        if $0 {
                            selectedSubjects.append(subject)
                        } else {
                            selectedSubjects.removeAll { $0 == subject }
                        }
                    }
                )) {
                    Text(subject)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .padding()
            
            TextField(
                "Group ID",
                text: $groupID
            )
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            .font(.system(size: 14)) // Adjust the size as needed
            .frame(width: 200) // Adjust the width as needed
            
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
            .frame(width: 200) // Adjust the width as needed
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

    var body: some View {
        VStack {
            Text("Group ID: \(groupID)")
                .font(.headline)
                .padding()
        }
        .navigationTitle("Dashboard")
        
        Text("Selected Subjects:")
            .font(.headline)
            .padding()
        
        ForEach(selectedSubjects, id: \.self) { subject in
            Text(subject)
                .padding(.leading)
        }
        
        Spacer()

        NavigationLink(destination: CalendarView()) {
            Image(systemName: "calendar")
                .imageScale(.large)
                .padding()
                .foregroundColor(.blue)
        }
        .padding(.trailing)
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
        NavigationView{
            VStack{
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
            .navigationTitle("Omu")
        }
    }
}

#Preview {
    ContentView()
}
