import SwiftUI

struct MarketplaceView: View {
    // Example data for the marketplace
    let items = ["Item 1", "Item 2", "Item 3"]

    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Marketplace")
        }
    }
}

struct MarketPlace_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceView()
    }
}
