import SwiftUI
import Combine

struct WardrobeView: View {
    var boughtClothes: [ClothingItem]
    var gender: String
    @State private var avatarImageName: String
    
    init(boughtClothes: [ClothingItem], gender: String) {
        self.gender = gender
        self.boughtClothes = boughtClothes
        // Initialize the @State variable based on the gender argument
        _avatarImageName = State(initialValue: gender)
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    ForEach(boughtClothes) { item in
                        HStack {
                            Image(item.imageName) // Placeholder for the item image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .onTapGesture {
                                    self.avatarImageName = "\(self.gender)-\(item.imageName)"
                                }
                        }
                        .padding()
                    }
                }.padding(.bottom, 300)
            }

            // Fixed avatar image at the bottom
            Image(avatarImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                .padding(.bottom, -40) // Adjusted to avoid overlap
        }
        .navigationTitle("My Wardrobe")
        .navigationBarTitleDisplayMode(.large)

    }
}
