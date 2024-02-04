import SwiftUI

struct AvatarCreationView: View {
    @State private var selectedGender: String = "Female"
    @State private var avatarImage: UIImage?
    @State private var isLoading: Bool = false
    @State private var isContinueButtonEnabled: Bool = false // To control the navigation button's state
    
    let genders = ["Male", "Female"]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Gender", selection: $selectedGender) {
                    ForEach(genders, id: \.self) { gender in
                        Text(gender).tag(gender)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Image(selectedGender).resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                
                
                // Continue button - enabled when avatarImage is not nil
                NavigationLink(destination: NextView(), isActive: $isContinueButtonEnabled) {
                    Button("Continue") {
                        isContinueButtonEnabled = true
                    }.buttonStyle(.bordered)
                    .controlSize(.large)
                    .buttonBorderShape(.roundedRectangle)
                  
                }
            }
            .navigationBarTitle("Customize Avatar", displayMode: .inline)
            .onAppear { createAvatar() }
        }
    }
    
    func createAvatar() {
        
        Image(selectedGender).resizable()
            .scaledToFit()
            .frame(width: 400, height: 400)
    
    }
}

struct AvatarCreationView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarCreationView()
    }
}

struct NextView: View {
    var body: some View {
        Text("Next Page")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}
