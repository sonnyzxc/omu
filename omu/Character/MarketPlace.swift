import SwiftUI

// Define a model for the clothing items with identifiable properties.
struct ClothingItem: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let price: Double
}

struct MarketPlace: View {
    var gender: String
    @State var clothes: [ClothingItem]
    @State private var playerMoney: Double = 100.00
    @State private var showingPurchaseAlert = false
    @State private var selectedItem: ClothingItem?
    @State var boughtClothes: [ClothingItem] = []
    var title: String
    
    // Initialize with gender to set up clothes and title based on gender
    init(gender: String) {
        self.gender = gender
        self.title = gender == "Male" ? "Men's Fashion" : "Women's Fashion"
        let initialClothes: [ClothingItem] = gender == "Male" ? [
            ClothingItem(imageName: "Male1", name: "Shirt", price: 10),
            ClothingItem(imageName: "Male2", name: "Moncler Puffer", price: 15),
            ClothingItem(imageName: "Male3", name: "Random Bear Costume", price: 25),
            ClothingItem(imageName: "Male4", name: "Random Cosplay Costume", price: 40)
        ] : [
            ClothingItem(imageName: "Female1", name: "Shirt", price: 10),
            ClothingItem(imageName: "Female2", name: "Moncler Puffer", price: 15),
            ClothingItem(imageName: "Female3", name: "Random Bear Costume", price: 25),
            ClothingItem(imageName: "Female4", name: "Random Cosplay Costume", price: 40)
        ]
        _clothes = State(initialValue: initialClothes)
    }
    
    var body: some View {
            NavigationView {
                ZStack(alignment: .bottom) {
                    VStack {
                        Text("Available Money: $\(playerMoney, specifier: "%.2f")")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                        
                        CarouselView(clothes: clothes, selectedItem: $selectedItem, showingPurchaseAlert: $showingPurchaseAlert)
                            .frame(height: 400)
                            .zIndex(1)
                        
                        Spacer()
                    }
                    
                    // Overlapping Avatar at the bottom
                    Image(gender) // Adjust the image names as per your assets
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .zIndex(0)
//                        .shadow(radius: 10)
                        .padding(.bottom, -50) // Adjust padding to ensure part of the avatar overlaps with the carousel
                }
                .navigationTitle(title)
                .navigationBarItems(trailing: NavigationLink(destination: WardrobeView(boughtClothes: boughtClothes, gender: gender)) {
                    Text("Wardrobe")
                })
                .alert(isPresented: $showingPurchaseAlert) {
                    Alert(title: Text("Purchase Item"),
                          message: Text("Do you want to buy \(selectedItem?.name ?? "") for $\(selectedItem?.price ?? 0, specifier: "%.2f")?"),
                          primaryButton: .default(Text("Buy"), action: {
                              if let price = selectedItem?.price, playerMoney >= price {
                                  playerMoney -= price
                                  if let boughtItem = selectedItem {
                                      boughtClothes.append(boughtItem)
                                      clothes.removeAll { $0.id == boughtItem.id }
                                  }
                              }
                          }),
                          secondaryButton: .cancel(Text("Cancel")))
                }
            }
        }
    
}

struct CarouselView: View {
    let clothes: [ClothingItem]
    @Binding var selectedItem: ClothingItem?
    @Binding var showingPurchaseAlert: Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 50) {
                ForEach(clothes) { item in
                    GeometryReader { geometry in
                        VStack {
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                .onTapGesture {
                                    self.selectedItem = item
                                    self.showingPurchaseAlert = true
                                }
                            
                            Text(item.name)
                                .font(.headline)
                            
                            Text("$\(item.price, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 150) / -10), axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: 200, height: 400)
                }
                
            }
            .padding()
        }
    }
}

// Provide a preview for the SwiftUI canvas.
struct MarketPlace_Previews: PreviewProvider {
    static var previews: some View {
        MarketPlace(gender: "Male")
    }
}

