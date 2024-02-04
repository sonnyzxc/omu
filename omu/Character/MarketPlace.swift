import SwiftUI

// Define a model for the clothing items with identifiable properties.
struct ClothingItem: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let price: Double
}
// Extension to convert hex color codes to SwiftUI Color.
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0xff00) >> 8) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

// Updated MarketPlace view
struct MarketPlace: View {
    
    // Changed to @State to allow the array to be mutable.
    @State var clothes: [ClothingItem]
    
    var title: String
    @State private var playerMoney: Double = 100.00
    @State private var showingPurchaseAlert = false
    @State private var selectedItem: ClothingItem?
    @State var boughtClothes: [ClothingItem] = []
    
    let themeColor = Color(hex: "#ff8a47")
    
    init(gender: String) {
        self.title = gender == "male" ? "Men's Fashion" : "Women's Fashion"
        _clothes = State(initialValue: gender == "male" ? [
            ClothingItem(imageName: "Male1", name: "Shirt", price: 10),
            ClothingItem(imageName: "Male2", name: "Moncler Puffer", price: 15),
            ClothingItem(imageName: "Male3", name: "Random Bear Costume", price: 25),
            ClothingItem(imageName: "Male4", name: "Random Cosplay Costume", price: 40)
        ] : [
            ClothingItem(imageName: "Female1", name: "Shirt", price: 10),
            ClothingItem(imageName: "Female2", name: "Moncler Puffer", price: 15),
            ClothingItem(imageName: "Female3", name: "Random Bear Costume", price: 25),
            ClothingItem(imageName: "Female4", name: "Random Cosplay Costume", price: 40)
        ])
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Available Money: $\(playerMoney, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(themeColor)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    .padding(.bottom, 5)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(clothes) { item in
                            VStack(alignment: .leading) {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                    .onTapGesture {
                                        self.selectedItem = item
                                        self.showingPurchaseAlert = true
                                    }
                                
                                Text(item.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text("$\(item.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(themeColor)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .background(.white)
            .alert(isPresented: $showingPurchaseAlert) {
                Alert(title: Text("Purchase Item"),
                      message: Text("Do you want to buy \(selectedItem?.name ?? "") for $\(selectedItem?.price ?? 0, specifier: "%.2f")?"),
                      primaryButton: .default(Text("Buy").foregroundColor(.white) action: {
                          if let price = selectedItem?.price, playerMoney >= price {
                              playerMoney -= price
                              if let boughtItem = selectedItem {
                                  boughtClothes.append(boughtItem)
                                  clothes.removeAll { $0.id == boughtItem.id }
                              }
                          }
                      }),
                      secondaryButton: .cancel(Text("Cancel").foregroundColor(themeColor)))
            }
        }
    }
}

// Provide a preview for the SwiftUI canvas.
struct MarketPlace_Previews: PreviewProvider {
    static var previews: some View {
        MarketPlace(gender: "male")
    }
}
