import SwiftUI

struct AContentView: View {
    @State private var avatarId: String = "64e3055495439dfcf3f0b665.png"
    @State private var avatarImage: UIImage?

    var body: some View {
        VStack {
            TextField("Enter Avatar ID", text: $avatarId)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            Button("Fetch Avatar") {
                fetch2DAvatar(avatarId: avatarId)
            }
            .padding()

            if let avatarImage = avatarImage {
                Image(uiImage: avatarImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .padding()
    }

    func fetch2DAvatar(avatarId: String) {
        guard let url = URL(string: "https://models.readyplayer.me/0.png") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching avatar: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                self.avatarImage = UIImage(data: data)
            }
        }

        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AContentView()
    }
}
