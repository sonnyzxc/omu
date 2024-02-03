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
                .onChange(of: selectedGender) { _ in createAvatar() }
                
                ZStack {
                    if isLoading || avatarImage == nil {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .frame(width: 300, height: 300)
                            .opacity(0) // Invisible, but occupies space
                    }
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                    } else if let avatarImage = avatarImage {
                        Image(uiImage: avatarImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                }
                .frame(width: 300, height: 300)
                .transition(.opacity.combined(with: .scale))
                
                // Continue button - enabled when avatarImage is not nil
                if let _ = avatarImage {
                    NavigationLink(destination: NextView(), isActive: $isContinueButtonEnabled) {
                        Button("Continue") {
                            isContinueButtonEnabled = true
                        }.buttonStyle(.bordered)
                        .controlSize(.large)
                        .buttonBorderShape(.roundedRectangle)
                        .disabled(avatarImage == nil) // Disable the button if the avatar image hasn't loaded
                    }
                }
            }
            .navigationBarTitle("Customize Avatar", displayMode: .inline)
            .onAppear { createAvatar() }
        }
    }
    
    func createAvatar() {
        isLoading = true
        
        let avatarURL: String = selectedGender == "Female" ?
            "https://models.readyplayer.me/65be905d71a2932853331799.png" :
            "https://models.readyplayer.me/65be95f07624741a0cd47a08.png"
        
        guard let url = URL(string: avatarURL) else {
            print("Invalid URL")
            isLoading = false
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    print("Error fetching avatar: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                self.avatarImage = image
            }
        }
        task.resume()
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
